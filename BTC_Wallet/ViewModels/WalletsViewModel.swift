// WalletsViewModel.swift

import Foundation

@MainActor class WalletsViewModel: ObservableObject {
    @Published var keychain: BTCKeychain?
    @Published var showMnemonic = false
    @Published var showNameAlert = false
    @Published var walletName = ""

    func saveName() {
        if walletName != "" {
            showMnemonic = true
        }
    }
}
