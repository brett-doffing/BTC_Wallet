// DataStore.swift

import Foundation

class DataStore: ObservableObject {
    static let shared = DataStore()

    private init() {
        load()
    }

    @Published var wallets: [Wallet] = []
    var currentWallet: Wallet?

    func save() {
        do {
            let fileURL = URL.documentsDirectory.appending(path: "Wallets.json")
            let walletsData = try JSONEncoder().encode(wallets)
            try walletsData.write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }

    func load() {
        let fileURL = URL.documentsDirectory.appending(path: "Wallets.json")
        if FileManager().fileExists(atPath: fileURL.path) {
            do {
                let walletsData = try Data(contentsOf: fileURL)
                wallets = try JSONDecoder().decode([Wallet].self, from: walletsData)
            } catch {
                print(error.localizedDescription)
            }
        }

    }

    func update(_ wallet: Wallet) {
        for (i, oldWallet) in wallets.enumerated() {
            if oldWallet.id == wallet.id {
                wallets.remove(at: i)
                wallets.insert(wallet, at: i)
                save()
                break
            }
        }
    }

    func saveNewWallet() {
        guard let wallet = currentWallet else { return }
        wallets += [wallet]
        save()
    }

    func delete(_ wallet: Wallet) {
        wallets.removeAll(where: { $0.id == wallet.id })
        save()
    }

    func deleteAllData() {
        let fileURL = URL.documentsDirectory.appending(path: "Wallets.json")
        if FileManager().fileExists(atPath: fileURL.path) {
            do {
                wallets = []
                currentWallet = nil
                try FileManager.default.removeItem(at: fileURL)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
