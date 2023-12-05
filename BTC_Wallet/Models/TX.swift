// TX.swift

import Foundation

struct TX: Codable, Identifiable {
    var blockHeight: Int?
    var blockTime: Int?
    var confirmed: Bool
    var fee: Int
    var id: String
    var locktime: Int
    var size: Int
    var version: Int
    var weight: Int
    var v_in: [V_in]
    var v_out: [V_out]
}
