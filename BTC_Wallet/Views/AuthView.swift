// AuthView.swift

import LocalAuthentication
import SwiftUI

struct AuthView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var shouldDismiss = false
    @State var shouldAlert = false
    @State var shouldPrompt = false
    @State var errorMessage: String?

    var body: some View {
        ZStack {
            backgroundImage
            prompt
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("btcOrange"), .black]), startPoint: .topLeading, endPoint: .bottom)
        )
        .onAppear { authenticate() }
        .onChange(of: $shouldDismiss.wrappedValue) { _ in
            presentationMode.wrappedValue.dismiss()
        }
        .alert("Authentication Error", isPresented: $shouldAlert, actions: {
            Button("OK") {
                errorMessage = nil
                shouldAlert = false
                shouldPrompt = true
            }
        }, message: {
            Text($errorMessage.wrappedValue ?? "Unknown Error")
        })
    }

    private var prompt: some View {
        Text("Swipe up to authenticate")
            .foregroundColor(Color.white)
            .disabled(!shouldPrompt)
    }

    private var backgroundImage: some View {
        VStack {
            Image(systemName: "bitcoinsign.circle.fill")
                .resizable()
                .foregroundColor(.white)
                .opacity(0.1)
                .aspectRatio(contentMode: .fill)
                .rotationEffect(.degrees(30))
        }
    }

    private func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "To unlock the app."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                if success {
                    shouldDismiss.toggle()
                } else {
                    if let authError = authError as? LAError {
                        errorMessage = handle(authError)
                    }
                    shouldAlert = true
                }
            }
        } else {
            if let authError = error as? LAError {
                errorMessage = handle(authError)
            }
            shouldAlert = true
        }
    }

    private func handle(_ error: LAError) -> String? {
        switch error.code {
        case .authenticationFailed:
            return "Authentication failed"
        case .userCancel:
            return "Cancelled authentication"
        case .systemCancel:
            return "System canceled authentication"
        case .passcodeNotSet:
            return "Please go to the Settings & Turn On Passcode"
        case .biometryNotAvailable:
            return "TouchID or FaceID not available"
        case .biometryNotEnrolled:
            return "TouchID or FaceID not enrolled"
        case .biometryLockout:
            return "TouchID or FaceID is locked because there were too many failed attempts, Please go to the Settings & Turn On Passcode"
        case .appCancel:
            return "App canceled authentication"
        case .invalidContext:
            return "Invalid Context"
        case .userFallback:
            return "No fallback is available for the authentication policy"
        case .notInteractive:
            return "Displaying the required authentication user interface is forbidden"
        default:
            return nil
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
