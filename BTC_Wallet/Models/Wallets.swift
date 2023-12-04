// Wallets.swift

import Foundation

class Wallets: ObservableObject {
    @Published var wallets: [Wallet] = []

    init() {
        let decoder = JSONDecoder()
        if let savedWallets = UserDefaults.standard.object(forKey: "wallets") as? Data,
           let wallets = try? decoder.decode([Wallet].self, from: savedWallets)
        {
            self.wallets = wallets
        }
    }

    func save(_ wallets: [Wallet]) {
        let encoder = JSONEncoder()
        if let encodedWallets = try? encoder.encode(wallets) {
            UserDefaults.standard.set(encodedWallets, forKey: "wallets")
        }
    }

    func save() {
        save(wallets)
    }

    func save(_ wallet: Wallet) {
        wallets += [wallet]
        save()
    }
}
