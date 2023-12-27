// SendViewModel.swift

import CodeScanner
import Foundation

@MainActor class SendViewModel: ObservableObject {
    @Published var fee = ""
    @Published var address = ""
    @Published var amountToSend = ""
    @Published var canSend = false
    @Published var showAlert = false
    @Published var showWalletSheet = false
    @Published var isShowingScanner = false
    @Published var selectUTXOs = false
    @Published var selectedUTXOs: [V_out] = []
    @Published var changeWallet: Wallet?

    var alertMessage = ""
    var store = DataStore.shared

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

    func validateTransaction() {
        var total = 0.0
        for vout in selectedUTXOs {
            total += vout.value
        }

        // TODO: validate bitcoin address
        if address == "" {
            alertMessage = "Address field is empty."
            showAlert = true
            return
        }

        guard let sendAmount = Double(amountToSend),
              let feeAmount = Double(fee),
              total < (sendAmount + feeAmount) || total != 0
        else {
            alertMessage = "The value of the selected outputs does not cover the cost of the transaction."
            showAlert = true
            return
        }

        canSend = true
    }

    func createTransaction() {
        // Send and change addresses
        // amount to change address should be utxo total - send amount - fee
        // check if amounts, like fees, work
        var total = 0.0

        for vout in selectedUTXOs {
            total += vout.value
        }

        guard let sendAmount = Double(amountToSend),
              let feeAmount = Double(fee),
              total < (sendAmount + feeAmount) || total != 0
        else { return }

        let hasChange = false

//        let transaction = Transaction(
//            receivingAddresses: <#T##[String]#>,
//            receiverAmounts: <#T##[UInt64]#>,
//            utxos: selectedUTXOs
//        )
    }
}
