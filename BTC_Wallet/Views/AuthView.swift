// AuthView.swift

import LocalAuthentication
import SwiftUI

struct AuthView: View {
    @Environment(\.presentationMode) var prentationMode

    var body: some View {
        ZStack {
            Color("btcOrange")
                .edgesIgnoringSafeArea(.all)
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock App"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                if success {
                    prentationMode.wrappedValue.dismiss()
                } else {

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
