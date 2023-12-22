// WalletViewModel.swift

//import Foundation
import SwiftUI

@MainActor class WalletViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var copied = false
    @Published var wallet = Wallet()
    
    private let service = BlockstreamService()
    private var store = DataStore.shared

    init() {
        if let currentWallet = store.currentWallet {
            self.wallet = currentWallet
        } else {
            // HANDLE ERROR
        }
    }

    func fetchTransactions() async {
        guard let address = wallet.receiveAddress else { return }
        await getTXs(forAddress: address)
    }

    private func getTXs(forAddress address: String) async {
        do {
            let responseData = try await service.fetchTransactions(for: address)
            if !responseData.isEmpty {
                await MainActor.run {
                    flagTXs(in: responseData)
                    self.getNextAddress()
                }
            } else {
                await MainActor.run { isLoading = false }
            }
        } catch {
            print(error)
        }
    }

    /// Flag wallet specific TXs
    private func flagTXs(in txs: [BlockstreamResponse]) {
        var txs = txs
        for (i, _) in txs.enumerated() {
            if let address = wallet.receiveAddress {
                txs[i].map(to: address)
            }
            let mappedTX = txs[i].mapped()
            wallet.transactions.append(mappedTX)
        }
    }

    private func getNextAddress() {
        wallet.walletIndex += 1
        Task { await fetchTransactions() }
    }

    func refresh() async {
//        isLoading = true
//        checkUnconfirmedTXs()
//        if let address = self.address {
//            await getTXs(forAddress: address)
//        }
    }
}
