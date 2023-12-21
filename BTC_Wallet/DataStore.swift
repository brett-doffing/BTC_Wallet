// DataStore.swift

import Foundation

class DataStore {
    static let shared = DataStore()

    private init() {
        load()
    }

    var wallets: [Wallet] = []
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
}
