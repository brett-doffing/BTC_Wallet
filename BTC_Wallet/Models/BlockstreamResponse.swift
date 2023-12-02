// BlockstreamResponse.swift

import Foundation
import CoreData

struct BlockstreamResponse: Codable, Identifiable {
    var txid: String
    var size: Int64
    var locktime: Int64
    var weight: Int64
    var version: Int64
    var fee: Int64
    var status: BlockInfo
    var vin: [V_in]
    var vout: [V_out]

    var id: String { txid }

//    func mapped(viewContext: NSManagedObjectContext) -> TX {
//        /// Initialize this way, instead of TX(context:) to silence ambiguous instances warning
//        let newTX = NSEntityDescription.insertNewObject(
//            forEntityName: "TX",
//            into: viewContext
//        ) as! TX
//
//        newTX.id = txid
//        newTX.fee = fee
//        newTX.locktime = locktime
//        newTX.size = size
//        newTX.version = version
//        newTX.weight = weight
//        if let blockHeight = status.block_height,
//           let blockTime = status.block_time
//        {
//            newTX.blockHeight = blockHeight
//            newTX.blockTime = blockTime
//        }
//        newTX.confirmed = status.confirmed
//        var cdVin: [V_IN] = []
//        for vin in vin {
//            let newVin = NSEntityDescription.insertNewObject(
//                forEntityName: "V_IN",
//                into: viewContext
//            ) as! V_IN
//
//            newVin.isCoinbase = vin.is_coinbase
//            newVin.scriptSig = vin.scriptsig
//            newVin.sequence = vin.sequence
//            newVin.txid = vin.txid
//            newVin.vout = vin.vout
//            newVin.witness = vin.witness
//            cdVin.append(newVin)
//        }
//        newTX.v_in = NSSet(array: cdVin)
//
//        var cdVout: [V_OUT] = []
//        for (i, vout) in vout.enumerated() {
//            let newVout = NSEntityDescription.insertNewObject(
//                forEntityName: "V_OUT",
//                into: viewContext
//            ) as! V_OUT
//
//            newVout.address = vout.scriptpubkey_address
//            newVout.n = Int64(i)
//            if let isWalletTXO = vout.isTXO { newVout.isWalletTXO = isWalletTXO }
//            newVout.scriptPubKey = vout.scriptpubkey
//            newVout.type = vout.scriptpubkey_type
//            newVout.value = vout.value
//            cdVout.append(newVout)
//        }
//        newTX.v_out = NSSet(array: cdVout)
//        return newTX
//    }
}

struct V_out: Codable {
    var scriptpubkey: String
    var scriptpubkey_asm: String
    var scriptpubkey_address: String?
    var scriptpubkey_type: String
    var value: Double
    /// Non API
    var isTXO: Bool? // Used to flag wallet TXO
    var n: Int64? // Used for TX creation
    var txid: String? // Used for TX creation

    mutating func toggleIsTXO() { self.isTXO = true }
}

struct V_in: Codable {
    var is_coinbase: Bool
    var prevout: V_out
    var scriptsig: String
    var scriptsig_asm: String
    var sequence: Int64
    var txid: String
    var vout: Int64
    var witness: [String]?
}

struct BlockInfo: Codable { // referred to as "status" in json response
    var block_hash: String?
    var block_time: Int64?
    var block_height: Int64?
    var confirmed: Bool
}
