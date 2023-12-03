// V_IN.swift

import Foundation

struct V_IN {
    var isCoinbase: Bool
    var scriptSig: String?
    var sequence: Int64
    var txid: String?
    var vout: Int64
    var witness: [String]?
}
