// V_OUT.swift

import Foundation

struct V_out: Codable {
    var scriptpubkey: String
    var scriptpubkey_asm: String
    var scriptpubkey_address: String?
    var scriptpubkey_type: String?
    var value: Double
    var n: Int?

    /// Non API
    var isTXO: Bool? // Flag wallet TXO
    var isChange: Bool? // Denotes wallet change
    var isSpent: Bool? // Unspent (U)TXO
    var txid: String? // Used for TX creation?

    mutating func toggleIsTXO() { self.isTXO = true }
    mutating func toggleIsChange() { self.isChange = true }
    mutating func toggleIsSpent() { self.isSpent = true }
    mutating func setTXID(_ txid: String) { self.txid = txid }
}
