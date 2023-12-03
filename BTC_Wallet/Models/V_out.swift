// V_OUT.swift

import Foundation

struct V_out: Codable {
    var scriptpubkey: String
    var scriptpubkey_asm: String
    var scriptpubkey_address: String?
    var scriptpubkey_type: String
    var value: Double
    /// Non API
    var isTXO: Bool? // Used to flag wallet TXO
    var n: Int? // Used for TX creation
    var txid: String? // Used for TX creation

    mutating func toggleIsTXO() { self.isTXO = true }
}
