// V_IN.swift

import Foundation

struct V_in: Codable {
    var is_coinbase: Bool
    var prevout: V_out // Array?
    var scriptsig: String
//    var scriptsig_asm: String
    var sequence: Int
    var txid: String
    var vout: Int
    var witness: [String]?
}
