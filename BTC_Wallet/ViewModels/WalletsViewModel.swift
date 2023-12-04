// WalletsViewModel.swift

import Foundation

@MainActor class WalletsViewModel: ObservableObject {
    @Published var keychain: BTCKeychain?
    @Published var showMnemonic = false
    @Published var showNameAlert = false
    @Published var wallets: [Wallet] = []
    @Published var walletName = ""

    func getWallets() {
        let decoder = JSONDecoder()
        if let savedWallets = UserDefaults.standard.object(forKey: "wallets") as? Data,
           let wallets = try? decoder.decode([Wallet].self, from: savedWallets)
        {
            self.wallets = wallets
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
