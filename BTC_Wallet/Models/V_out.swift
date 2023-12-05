// V_OUT.swift

import Foundation

struct V_out: Codable {
    var scriptpubkey: String
    var scriptpubkey_asm: String
    var scriptpubkey_address: String?
    var scriptpubkey_type: String?
    var value: Double

    /// Non API
    var n: Int? // Sequence number
    var isTXO: Bool? // Flag wallet TXO
    var isChange: Bool? // Denotes wallet change
    var isSpent: Bool? // Unspent (U)TXO
    var txid: String? // Used for TX creation?
}
