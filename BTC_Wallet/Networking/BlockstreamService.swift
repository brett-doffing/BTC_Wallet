// BlockstreamService.swift

import Foundation

protocol BlockstreamServiceable {
    func fetchTransactions(for address: String) async throws -> [BlockstreamResponse]
}

struct BlockstreamService: BlockstreamServiceable {
    private let baseURL = "https://blockstream.info/testnet/api/"
    private let defaults = UserDefaults.standard

    func fetchTransactions(for address: String) async throws -> [BlockstreamResponse] {
        var urlString = baseURL + "address/\(address)/txs"
        return try await request(with: urlString, type: [BlockstreamResponse].self)
    }

    func request<T: Codable>(with urlString: String, type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.InvalidHTTPURLResponse }
            if !(response.statusCode >= 200 && response.statusCode < 300) {
                throw NetworkError.invalidStatusCode(statusCode: response.statusCode)
            }

            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded

        } catch {
            throw NetworkError.failedToDecode(error: error)
        }
    }
}

extension BlockstreamService {
    enum NetworkError: Error {
        case invalidURL
        case InvalidHTTPURLResponse
        case invalidStatusCode(statusCode: Int)
        case failedToDecode(error: Error)

        var localizedDescription: String {
            switch self {
            case .invalidURL:
                return "Invalid URL"
            case .InvalidHTTPURLResponse:
                return "Invalid HTTPURLResponse"
            case .invalidStatusCode(let statusCode):
                return "Invalid Status Code: \(statusCode)"
            case .failedToDecode(let error):
                return "Invalid Status Code: \(error.localizedDescription)"
            }
        }
    }
}
