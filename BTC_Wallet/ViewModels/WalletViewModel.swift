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
                    print(response)
                    if isCurrentAddress { self.incrementWalletIndex() }
                } else {
                    print("No transactions for this address:\n\t\(address)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }}
    }

    private func incrementWalletIndex() {

    }

    func refresh() {
//        checkUnconfirmedTXs()
//        if let address = self.address {
//            getTXs(forAddress: address)
//        }
    }
}
