// BlockstreamService.swift

import Foundation

protocol BlockstreamServiceable {
    func fetchTransactions(
        for address: String,
        lastSeenTX: String?
    ) async throws -> [BlockstreamResponse]
}

struct BlockstreamService: BlockstreamServiceable {
    private let baseURL = "https://blockstream.info/testnet/api/"
    private let defaults = UserDefaults.standard

    func fetchTransactions(
        for address: String,
        lastSeenTX: String? = nil
    ) async throws -> [BlockstreamResponse] {
        var urlString = baseURL + "address/\(address)/txs"
        if let lastSeenTX = lastSeenTX { urlString += "/chain/\(lastSeenTX)" } // Add last seen tx for address to api call
        guard let url = URL(string: urlString) else { throw "Bad URL when fetching a BlockstreamResponse" }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else { throw "No HTTP response?" }
            if !(response.statusCode >= 200 && response.statusCode < 300) {
                throw "Bad HTTP response status code."
            }

            let transactions = try JSONDecoder().decode([BlockstreamResponse].self, from: data)
            return transactions

        } catch {
            throw error
        }
    }
}
