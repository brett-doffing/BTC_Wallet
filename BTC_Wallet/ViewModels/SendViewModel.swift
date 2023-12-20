// SendViewModel.swift

import CodeScanner
import Foundation

@MainActor class SendViewModel: ObservableObject {
    @Published var fee = ""
    @Published var address = ""
    @Published var amountToSend = ""
    @Published var canSend = false
    @Published var isShowingScanner = false

    var utxos: [String] = []
    var recipients: [[String]] = []

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: ":")
            guard details.count == 2 else { return }

            address = details[1]
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}
