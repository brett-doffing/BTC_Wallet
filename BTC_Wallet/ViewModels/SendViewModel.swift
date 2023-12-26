// SendViewModel.swift

import CodeScanner
import Foundation

@MainActor class SendViewModel: ObservableObject {
    @Published var fee = ""
    @Published var address = ""
    @Published var amountToSend = ""
    @Published var canSend = false
    @Published var showAmountsAlerts = false
    @Published var isShowingScanner = false
    @Published var selectUTXOs = false
    @Published var selectedUTXOs: [V_out] = []

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

    func checkToSend() {
        guard let sendAmount = Double(amountToSend),
              let feeAmount = Double(fee)
        else { showAmountsAlerts = true; return }

        var total = 0.0
        for vout in selectedUTXOs {
            total += vout.value
        }
        if total >= (sendAmount + feeAmount) && total > 0 {
            canSend = true
        } else {
            showAmountsAlerts = true
        }
    }
}
