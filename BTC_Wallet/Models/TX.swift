// TX.swift

import Foundation

struct TX {
    var blockHeight: Int64
    var blockTime: Int64
    var confirmed: Bool
    var fee: Int64
    var id: String?
    var locktime: Int64
    var size: Int64
    var version: Int64
    var weight: Int64
    var v_in: NSSet?
    var v_out: NSSet?
}
