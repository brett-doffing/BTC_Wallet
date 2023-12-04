// WalletViewModel.swift

import Foundation

@MainActor class WalletViewModel: ObservableObject {
    @Published var keychain: BTCKeychain?
    @Published var address: String?
    @Published var isLoading = false
    @Published var transactions: [TX] = []
    private let service = BlockstreamService()

    let wallet: Wallet

    init(_ wallet: Wallet) {
        self.wallet = wallet
        guard let mnemonic = wallet.mnemonic else { return }
        let seed = Mnemonic.createSeed(mnemonic: mnemonic)
        let masterKeychain = BTCKeychain(seed: seed)
        let coinType = masterKeychain.network.coinType
        if let kc = masterKeychain.derivedKeychain(withPath: "m/84'/\(coinType)'/0'", andType: .BIP84),
           let address = kc.recieveKeychain(atIndex: UInt32(wallet.walletIndex), withType: .BIP84)?.address
        {
            self.keychain = kc
            self.address = address
//            getTXs(forAddress: address, isCurrentAddress: true)
        }
    }

    func refresh() {
//        checkUnconfirmedTXs()
//        if let address = self.address {
//            getTXs(forAddress: address)
//        }
    }
}
