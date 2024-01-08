// BlockstreamService.swift

import Foundation

protocol BlockstreamServiceable {
    func fetchTransactions(for address: String) async throws -> [BlockstreamResponse]
    func post(rawTX: String) async throws -> String
}

struct BlockstreamService: BlockstreamServiceable {
    private let baseURL = "https://blockstream.info/testnet/api/"
    private let defaults = UserDefaults.standard

    /**
     Fetches transactions for a given address

     - Parameters:
        - address: The address to fetch transactions for
     - Returns: An array of `BlockstreamResponse` objects
     */
    func fetchTransactions(for address: String) async throws -> [BlockstreamResponse] {
        let urlString = baseURL + "address/\(address)/txs"
        return try await request(with: urlString, type: [BlockstreamResponse].self)
    }

    /**
    Posts a raw transaction to the Blockstream API
    - Parameters:
       - rawTX: The raw transaction to post
    - Returns: The transaction ID
    */
    func post(rawTX: String) async throws -> String {
        let urlString = baseURL + "tx"
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        guard let txData = rawTX.data(using: .utf8) else { throw NetworkError.failedToEncode }
        request.httpBody = txData

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.InvalidHTTPURLResponse }
            guard (200 ... 299) ~= response.statusCode else {
                throw NetworkError.invalidStatusCode(statusCode: response.statusCode)
            }
            guard let encoded = String(data: data, encoding: .utf8) else { throw NetworkError.failedToEncode }
            return encoded
        } catch {
            throw NetworkError.failedToDecode(error: error)
        }
    }

    /**
     Generic request function
     - Parameters:
        - urlString: The URL to request
        - type: The type to decode the response to
     - Returns: The decoded response
     */
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
        case failedToEncode

        var localizedDescription: String {
            switch self {
            case .invalidURL:
                return "Invalid URL"
            case .InvalidHTTPURLResponse:
                return "Invalid HTTPURLResponse"
            case .invalidStatusCode(let statusCode):
                return "Invalid Status Code: \(statusCode)"
            case .failedToDecode(let error):
                return "Failed to Decode: \(error.localizedDescription)"
            case .failedToEncode:
                return "Failed to Encode"
            }
        }
    }
}
