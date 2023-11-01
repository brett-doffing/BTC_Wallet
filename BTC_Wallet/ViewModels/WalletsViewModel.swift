// WalletsViewModel.swift

import Foundation

@MainActor class WalletsViewModel: ObservableObject {
    @Published var keychain: BTCKeychain?
    @Published var isLoading = false
    @Published var needsMnemonic = false

    func checkForMnemonic() {
        if let mnemonic = UserDefaults.standard.string(forKey: "mnemonic") {
            needsMnemonic = false
            let seed = Mnemonic.createSeed(mnemonic: mnemonic)
        } else {
            needsMnemonic = true
        }
    }

    func randomlyGenerateSeed() {
        isLoading = true
        let mnemonic = Mnemonic.createRandom()

        // TODO: Save Securely
        UserDefaults.standard.set(mnemonic, forKey: "mnemonic")
//            let kcpi = KeychainPasswordItem(service: "wallet", account: "satoshi")
//            do { try kcpi.savePassword(mnemonic) }
//            catch let kcError {
//                print("error = \(kcError)")
//                isLoading = false
//                return
//            }
        isLoading = false
    }
}
