// V_OUT.swift

import Foundation

struct V_OUT {
    var address: String?
    var isChange: Bool
    var isWalletTXO: Bool
    var n: Int64
    var scriptPubKey: String?
    var type: String?
    var value: Double
    var tx: TX?
}
