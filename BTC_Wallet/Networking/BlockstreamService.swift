// BlockstreamService.swift

import Foundation

protocol BlockstreamService {
    func getTransactions(for address: String, lastSeenTX: String?) async throws -> [BlockstreamResponse]
}

struct _BlockstreamService: BlockstreamService {
    private let baseURL = "https://blockstream.info/testnet/api/"
    private let defaults = UserDefaults.standard

    func getTransactions(for address: String, lastSeenTX: String? = nil) async throws -> [BlockstreamResponse] {
        var urlString = baseURL + "address/\(address)/txs"
        if let lastSeenTX = lastSeenTX { urlString += "/chain/\(lastSeenTX)" }
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
