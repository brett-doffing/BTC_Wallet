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

    mutating func map(to address: String, and walletId: UUID) {
        for (i, _) in vout.enumerated() {
            if let vOutAddr = vout[i].scriptpubkey_address,
               vOutAddr == address
            {
                vout[i].isTXO = true
                vout[i].txid = self.txid
                vout[i].n = UInt32(i)
                vout[i].walletId = walletId
            }
        }
//
//        for (i, _) in vin.enumerated() {
//            if let vInAddr = vin[i].prevout.scriptpubkey_address,
//               vInAddr == address
//            {
//
//            }
//        }
    }
}
