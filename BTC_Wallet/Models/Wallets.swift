// Wallets.swift

import Foundation

class Wallets: ObservableObject {
    @Published var wallets: [Wallet] = []

    init() {
        getWallets()
    }

    func getWallets() {
        let decoder = JSONDecoder()
        if let savedWallets = UserDefaults.standard.object(forKey: "wallets") as? Data,
           let wallets = try? decoder.decode([Wallet].self, from: savedWallets)
        {
            self.wallets = wallets
        } else {
            self.wallets = []
        }
    }

    func save() {
        let encoder = JSONEncoder()
        if let encodedWallets = try? encoder.encode(wallets) {
            UserDefaults.standard.set(encodedWallets, forKey: "wallets")
        }
    }

    func save(_ wallets: [Wallet]) {
        self.wallets = wallets
        save()
    }

    func save(_ wallet: Wallet) {
        wallets += [wallet]
        save()
    }
}
