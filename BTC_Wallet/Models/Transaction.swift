// Transaction.swift

import Foundation

struct Transaction {
    var receivingAddresses: [String]
    var receiverAmounts: [UInt64]
    var utxos: [V_out]
    var fee: Int
    // TODO: per vByte
    var feePerByte: Int {
        guard let rawTX else { return 0 }
        return Int(fee / rawTX.bytes.count)
    }
    var privateKeys: [[UInt8]] {
        if _privateKeys.isEmpty {
            return utxos.compactMap { vout in
                let wallet = DataStore.shared.wallets.first { $0.id.uuidString == vout.walletId }
                let kc = wallet?.keychain?.receiveKeychain(atIndex: vout.walletIndex ?? 0)
                let privateKey = kc?.extendedPrivateKey?.privateKey.bytes
                return privateKey
            }
        } else {
            return _privateKeys
        }
    }
    /// A property that can be passed in for testing purposes,
    /// otherwise private keys are derived from wallets.
    var _privateKeys: [[UInt8]] = []

    var rawTX: Data? {
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
