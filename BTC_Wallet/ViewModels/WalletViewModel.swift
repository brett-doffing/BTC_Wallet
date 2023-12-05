// WalletViewModel.swift

import Foundation

@MainActor class WalletViewModel: ObservableObject {
    @Published var keychain: BTCKeychain?
    @Published var address: String?
    @Published var isLoading = false
    @Published var transactions: [TX] = []
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

    func getTransactionForCurrentAddress() async {
        guard let address else { return }
        await getTXs(forAddress: address, isCurrentAddress: true)
    }

    private func getTXs(forAddress address: String, lastSeenTX: String? = nil, isCurrentAddress: Bool = false) async {
        await service.getTransactions(for: address, lastSeenTX: lastSeenTX) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                if !response.isEmpty {
                    flagTXs(in: response)
                    if isCurrentAddress { self.getNextAddress() }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }}
    }

    /// Flag wallet specific TXOs
    private func flagTXs(in txs: [BlockstreamResponse]) {
        var txs = txs
        for (i, response) in txs.enumerated() {
            for (j, _) in txs[i].vout.enumerated() {
                if let vOutAddr = txs[i].vout[j].scriptpubkey_address,
                   let address = self.address,
                   vOutAddr == address
                {
                    txs[i].vout[j].isTXO = true
                    txs[i].vout[j].txid = response.txid
                    txs[i].vout[j].n = j
                }
            }
            let mappedTX = txs[i].mapped()
            DispatchQueue.main.async { [weak self] in
                self?.transactions.append(mappedTX)
            }
        }
    }

    private func getNextAddress() {
        wallet.walletIndex += 1
        if let address = self.keychain?.recieveKeychain(atIndex: UInt32(wallet.walletIndex))?.address {
            DispatchQueue.main.async { [weak self] in
                self?.address = address
            }
            Task { await getTransactionForCurrentAddress() }
        }
    }

    func refresh() {
//        checkUnconfirmedTXs()
//        if let address = self.address {
//            getTXs(forAddress: address)
//        }
    }
}
