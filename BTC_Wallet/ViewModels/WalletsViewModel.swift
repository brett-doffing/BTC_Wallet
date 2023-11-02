// WalletsViewModel.swift

import Foundation

@MainActor class WalletsViewModel: ObservableObject {
    @Published var keychain: BTCKeychain?
    @Published var needsMnemonic = false

    func checkForMnemonic() {
        if let mnemonic = UserDefaults.standard.string(forKey: "mnemonic") {
            needsMnemonic = false
            let seed = Mnemonic.createSeed(mnemonic: mnemonic)
        } else {
            needsMnemonic = true
        }
    }
}
