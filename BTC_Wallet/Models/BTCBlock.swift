// BTCBlock.swift

import Foundation

struct BTCBlock: Codable { // referred to as "status" in json response
    var block_hash: String?
    var block_time: Int?
    var block_height: Int?
    var confirmed: Bool
}
