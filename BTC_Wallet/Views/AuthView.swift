// AuthView.swift

import LocalAuthentication
import SwiftUI

struct AuthView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var shouldDismiss = false

    var body: some View {
        ZStack {
            Color("btcOrange")
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear { authenticate() }
        .onChange(of: $shouldDismiss.wrappedValue) { newValue in
            presentationMode.wrappedValue.dismiss()
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock App"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                if success {
                    shouldDismiss.toggle()
                } else {
                    print(authError?.localizedDescription)
                }
            }
        } else {
            // No Biometrics
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
