// BlockstreamResponse.swift

import Foundation
import CoreData

struct BlockstreamResponse: Codable, Identifiable {
    var txid: String
    var size: Int
    var locktime: Int
    var weight: Int
    var version: Int
    var fee: Int
    var status: BTCBlock
    var vin: [V_in]
    var vout: [V_out]

    var id: String { txid }

    func mapped() -> TX {
        TX(
            blockHeight: status.block_height,
            blockTime: status.block_time,
            confirmed: status.confirmed,
            fee: fee,
            id: txid,
            locktime: locktime,
            size: size,
            version: version,
            weight: weight,
            v_in: vin,
            v_out: vout
        )
    }
}
