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
    @Published var isLoading = false

    var alertMessage = ""
    var store = DataStore.shared
    var transaction: Transaction?

    /// Handles the result from the QR code scanner
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
            showAlert(message: "Address field is empty.")
            return
        }

        guard let sendAmount = Double(amountToSend),
              let feeAmount = Double(fee),
              total != 0
        else {
            showAlert(message: "Invalid amounts")
            return
        }

        if total < (sendAmount + feeAmount) {
            showAlert(message: "The value of the selected outputs does not cover the cost of the transaction.")
            return
        }

        var receivingAddresses = [address]
        var receiverAmounts = [UInt64(sendAmount)]

        let change = total - sendAmount - feeAmount

        if change > 0 {
            if let changeAddress = changeWallet?.changeAddress {
                receivingAddresses.append(changeAddress)
                receiverAmounts.append(UInt64(change))
            }
        }

        createTransaction(addresses: receivingAddresses, amounts: receiverAmounts, fee: Int(feeAmount))
    }

    private func createTransaction(addresses: [String], amounts: [UInt64], fee: Int) {
        isLoading = true
        let utxos = selectedUTXOs
        DispatchQueue.global(qos: .background).async {
            let tx = Transaction(
                receivingAddresses: addresses,
                receiverAmounts: amounts,
                utxos: utxos,
                fee: fee
            )

            DispatchQueue.main.async { [unowned self] in
                self.transaction = tx
                self.canSend = true
                self.isLoading = false
            }
        }
    }

    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}
