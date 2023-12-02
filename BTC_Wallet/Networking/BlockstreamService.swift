// BlockstreamService.swift

import Foundation

class BlockstreamService {
    static let shared = BlockstreamService()

    let baseURL = "https://blockstream.info/testnet/api/"
    let defaults = UserDefaults.standard

    private init() {}

    func getTransactions(for address: String, lastSeenTX: String? = nil) async throws -> [BlockstreamResponse] {
        var urlString = baseURL + "address/\(address)/txs"
        if let lastSeenTX = lastSeenTX { urlString += "/chain/\(lastSeenTX)"}
        guard let url = URL(string: urlString) else { throw "Bad URL when fetching a BlockstreamResponse" }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let transactions = try JSONDecoder().decode([BlockstreamResponse].self, from: data)
            return transactions
        } catch {
            throw "BlockstreamResponse Error"
        }
    }
}
