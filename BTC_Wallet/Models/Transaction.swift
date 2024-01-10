// Transaction.swift

import Foundation

struct Transaction {
    internal init(
        receivingAddresses: [String],
        receiverAmounts: [UInt64],
        utxos: [V_out],
        fee: Int,
        _privateKeys: [[UInt8]] = []
    ) {
        self.receivingAddresses = receivingAddresses
        self.receiverAmounts = receiverAmounts
        self.utxos = utxos
        self.fee = fee
        self._privateKeys = _privateKeys

        self.rawTX = setRawTX()
    }

    var receivingAddresses: [String]
    var receiverAmounts: [UInt64]
    var utxos: [V_out]
    var fee: Int
    var feePerVByte: Int {
        guard let rawTX else { return 0 }
        // Factor of four to convert bytes to weight units
        return Int(fee / (rawTX.bytes.count * 4))
    }
    var privateKeys: [[UInt8]] {
        if _privateKeys.isEmpty {
            return utxos.compactMap { vout in
                let wallet = DataStore.shared.wallets.first { $0.id.uuidString == vout.walletId }
                print(vout.walletIndex)
                let kc = wallet?.keychain?.receiveKeychain(atIndex: vout.walletIndex ?? 0, withType: .BIP44)
                let privateKey = kc?.extendedPrivateKey?.privateKey.bytes
                return privateKey
            }
        } else {
            return _privateKeys
        }
    }
    var rawTX: Data?

    /// Temp property that can be passed in for testing purposes,
    /// otherwise private keys are derived from wallets.
    var _privateKeys: [[UInt8]] = []

    private func setRawTX() -> Data? {
        var scriptSigs: [Data] = []
        var doubleSha256: [UInt8]

        var newRawTx = BTCTransaction.shared.createTX(
            scriptSigs: scriptSigs,
            satoshis: receiverAmounts,
            receivingAddresses: receivingAddresses,
            utxos: utxos
        )

        for (i, utxo) in utxos.enumerated() {
            newRawTx += UInt32(0x00000001).littleEndian
            doubleSha256 = newRawTx.doubleSHA256().bytes
            do {
                let signature: secp256k1_ecdsa_signature = try BTCCurve.shared.sign(
                    key: privateKeys[i],
                    message: doubleSha256
                )
                let publicKey = try BTCCurve.shared.generatePublicKey(
                    privateKey: privateKeys[i].data
                )
                var encodedSig = try BTCCurve.shared.encodeDER(signature: signature)
                guard let scriptPubKey = utxo.scriptpubkey.hexData()?.bytes else { return nil }

                encodedSig = BTCCurve.shared.appendDERbytes(
                    encodedDERSig: encodedSig,
                    hashType: 0x01,
                    scriptPubKey: scriptPubKey,
                    pubkey: publicKey.bytes
                )

                scriptSigs.append(encodedSig.data)

                newRawTx = BTCTransaction.shared.createTX(
                    scriptSigs: scriptSigs,
                    satoshis: receiverAmounts,
                    receivingAddresses: receivingAddresses,
                    utxos: utxos
                )
            } catch {
                return nil
            }
        }
        return newRawTx
    }
}
