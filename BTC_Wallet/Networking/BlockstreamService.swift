// BlockstreamService.swift

import Foundation

protocol BlockstreamServiceable {
    func getTransactions(
        for address: String,
        lastSeenTX: String?,
        completionHandler: @escaping ([BlockstreamResponse]?, Error?) -> ()
    ) async throws
}

struct BlockstreamService: BlockstreamServiceable {
    private let baseURL = "https://blockstream.info/testnet/api/"
    private let defaults = UserDefaults.standard

    func getTransactions(
        for address: String,
        lastSeenTX: String? = nil,
        completionHandler: @escaping ([BlockstreamResponse]?, Error?) -> ()) async throws {
        var urlString = baseURL + "address/\(address)/txs"
        if let lastSeenTX = lastSeenTX { urlString += "/chain/\(lastSeenTX)" }
        guard let url = URL(string: urlString) else { throw "Bad URL when fetching a BlockstreamResponse" }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let transactions = try JSONDecoder().decode([BlockstreamResponse].self, from: data)
            completionHandler(transactions, nil)
        } catch {
            throw "BlockstreamResponse Error"
        }
    }
}
