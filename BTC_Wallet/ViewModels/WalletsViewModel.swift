// WalletsViewModel.swift

import Foundation

@MainActor class WalletsViewModel: ObservableObject {
    @Published var keychain: BTCKeychain?
    @Published var showMnemonic = false
    @Published var showNameAlert = false
    @Published var wallets: [[String: String]] = []
    @Published var walletName = ""

    func getWallets() {
        if let savedWallets = UserDefaults.standard.object(forKey: "wallets") as? [[String: String]] {
            print(savedWallets)
            wallets = savedWallets
        } else {
            wallets = []
        }
    }

    func saveName() {
        if walletName != "" {
            showMnemonic = true
        }
    }
}
