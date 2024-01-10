// Wallet.swift

import Foundation

struct Wallet: Codable, Identifiable {
    var id = UUID()
    var name: String
    var changeIndex = 0
    var walletIndex = 0
    private var _txs: [TX] = []
    var transactions: [TX] {
        get {
            let sorted = _txs.sorted { (lhs, rhs) in
                switch (lhs.blockTime, rhs.blockTime) {
                case let(l?, r?): return l > r // Both lhs and rhs are not nil
                case (nil, _): return true    // Lhs is nil
                case (_?, nil): return false    // Lhs is not nil, rhs is nil
                }
            }
            return sorted
        }
        set {
            _txs = newValue
        }
    }
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

    init(name: String? = nil) {
        if let name {
            self.name = name
        } else {
            self.name = "New Wallet"
        }
    }
}
