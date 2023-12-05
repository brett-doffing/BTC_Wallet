// BlockstreamService.swift

import Foundation

protocol BlockstreamServiceable {
    func getTransactions(
        for address: String,
        lastSeenTX: String?,
        completionHandler: @escaping (Result<[BlockstreamResponse], Error>) -> ()
    ) async throws
}

struct BlockstreamService: BlockstreamServiceable {
    private let baseURL = "https://blockstream.info/testnet/api/"
    private let defaults = UserDefaults.standard

    func getTransactions(
        for address: String,
        lastSeenTX: String? = nil,
        completionHandler: @escaping (Result<[BlockstreamResponse], Error>) -> ()) async {
        var urlString = baseURL + "address/\(address)/txs"
        if let lastSeenTX = lastSeenTX { urlString += "/chain/\(lastSeenTX)" }
        guard let url = URL(string: urlString)
                
        else { completionHandler(.failure("Bad URL when fetching a BlockstreamResponse")); return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let transactions = try JSONDecoder().decode([BlockstreamResponse].self, from: data)
            completionHandler(.success(transactions))
        } catch {
            print(error.localizedDescription)
            completionHandler(.failure("BlockstreamResponse Error"))
        }
    }
}
