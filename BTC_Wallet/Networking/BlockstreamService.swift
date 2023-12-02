// BlockstreamService.swift

import Foundation

class BlockstreamService {
    static let shared = BlockstreamService()

    let baseURL = "https://blockstream.info/testnet/api/"
    let defaults = UserDefaults.standard

    private init() {}

    private func getRequest(withURL url: URL, completionHandler: @escaping (Data?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil { completionHandler(nil, error) }
            guard let data = data else { completionHandler(nil, error); return }
            completionHandler(data, nil)
        }.resume()
    }

    func getTransactions(for address: String, lastSeenTX: String? = nil) async {
        var urlString = baseURL + "address/\(address)/txs"
        if let lastSeenTX = lastSeenTX { urlString += "/chain/\(lastSeenTX)"}
        guard let url = URL(string: urlString) else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let transactions = try JSONDecoder().decode([String: String].self, from: data)
        } catch {
            print(error)
        }
    }
}
