// WalletViewModel.swift

//import Foundation
import SwiftUI

@MainActor class WalletViewModel: ObservableObject {
    @Published var keychain: BTCKeychain?
    @Published var address: String?
    @Published var isLoading = true
    @Published var transactions: [TX] = []
    @Published var copied = false
    
    private let service = BlockstreamService()

    var wallet: Wallet

    init(_ wallet: Wallet) {
        self.wallet = wallet
        guard let mnemonic = wallet.mnemonic else { return }
        let seed = Mnemonic.createSeed(mnemonic: mnemonic)
        let masterKeychain = BTCKeychain(seed: seed)
        let coinType = masterKeychain.network.coinType
        if let kc = masterKeychain.derivedKeychain(withPath: "m/44'/\(coinType)'/0'", andType: .BIP44),
           let address = kc.recieveKeychain(atIndex: UInt32(wallet.walletIndex), withType: .BIP44)?.address
        {
            self.keychain = kc
            self.address = address
        }
    }

    func fetchTransactions() async {
        guard let address else { return }
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
            if let address = self.address {
                txs[i].map(to: address)
            }
            let mappedTX = txs[i].mapped()
            self.transactions.append(mappedTX)
        }
    }

    private func getNextAddress() {
        wallet.walletIndex += 1
        if let address = self.keychain?.recieveKeychain(atIndex: UInt32(wallet.walletIndex))?.address {
            self.address = address
            Task { await fetchTransactions() }
        }
    }

    func refresh() async {
//        isLoading = true
//        checkUnconfirmedTXs()
//        if let address = self.address {
//            await getTXs(forAddress: address)
//        }
    }
}
