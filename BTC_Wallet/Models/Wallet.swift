// Wallet.swift

import Foundation

struct Wallet: Codable, Identifiable {
    var id = UUID()
    var name = "New Wallet"
    var changeIndex = 0
    var walletIndex = 0
    var transactions: [TX] = []
    var mnemonic: String?

    var keychain: BTCKeychain? {
        guard let mnemonic else { return nil }
        let seed = Mnemonic.createSeed(mnemonic: mnemonic)
        let masterKeychain = BTCKeychain(seed: seed)
        let coinType = masterKeychain.network.coinType // Can change?
        return masterKeychain.derivedKeychain(withPath: "m/44'/\(coinType)'/0'", andType: .BIP44)
    }
    var receiveKeychain: BTCKeychain? {
        return keychain?.receiveKeychain(atIndex: UInt32(walletIndex), withType: .BIP44)
    }
    var changeKeychain: BTCKeychain? {
        return keychain?.changeKeychain(atIndex: UInt32(changeIndex), withType: .BIP44)
    }
    var receiveAddress: String? { receiveKeychain?.address }
    var changeAddress: String? { changeKeychain?.address }
}
