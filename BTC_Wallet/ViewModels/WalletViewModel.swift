// WalletViewModel.swift

import SwiftUI

@MainActor class WalletViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var copiedAddress = false
    @Published var wallet: Wallet
    
    private let service = BlockstreamService()
    private var store = DataStore.shared
    private var didUpdate = false

    init() {
        assert(store.currentWallet != nil)
        self.wallet = store.currentWallet!
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
                    didUpdate = true
                    flagTXs(in: responseData)
                    getNextAddress()
                }
            } else {
                await MainActor.run {
                    if didUpdate {
                        store.update(wallet)
                    }
                    isLoading = false
                }
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
                txs[i].map(to: address, from: wallet)
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
