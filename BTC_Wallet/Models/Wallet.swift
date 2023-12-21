// Wallet.swift

import Foundation

struct Wallet: Codable, Identifiable {
    var name: String = "New Wallet"
    var changeIndex = 0
    var walletIndex = 0
    /// Holds `[TX.id]` for reference, instead of entire TX
    var transactions: [String] = []
    var mnemonic: String?

    var id: String { self.name }
}
