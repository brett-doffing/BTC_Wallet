// BTCCurve.swift

import Foundation

/**
Singleton for performing Bitcoin Elliptic Curve operations.

 [Randomize context]: https://bitcoin.stackexchange.com/questions/52254/c-secp256k1-what-is-the-purpose-of-secp256k1-context-randomize
 - TODO: [Randomize context]
 */
class BTCCurve {
    static let shared = BTCCurve()
    let context: secp256k1_context?
    // TODO: Get rid of BInt Library
    let order = BInt(hex: "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141")
    
    private init() {
        self.context = secp256k1_context_create([SECP256K1_FLAGS.SECP256K1_CONTEXT_SIGN, SECP256K1_FLAGS.SECP256K1_CONTEXT_VERIFY])
    }
    
    func ECDH(withPubkey publicKey: secp256k1_pubkey, andPrivateKey privateKey: Data) throws -> Data {
        guard let ctx = self.context else { throw CurveError.contextError }
        var pubkey = publicKey
        if !(secp256k1_ec_pubkey_tweak_mul(ctx, &pubkey, privateKey.bytes)) { throw CurveError.tweakMulPubkeyError }
        var serializedPubkey = [UInt8](repeating: 0, count:33)
        var length = UInt(33)
        if !(secp256k1_ec_pubkey_serialize(ctx, &serializedPubkey, &length, pubkey, [SECP256K1_FLAGS.SECP256K1_EC_COMPRESSED])) { throw CurveError.serializePubkeyError }
        return serializedPubkey.data
    }
    
    /// Multiplies tweak by generator point and adds to public key point.
    func add(_ publicKey: Data, _ tweak: Data) throws -> Data {
        guard let ctx = self.context else { throw CurveError.contextError }
        var pubkey = secp256k1_pubkey()
        if !secp256k1_ec_pubkey_parse(ctx, &pubkey, publicKey.bytes, UInt(publicKey.count)) { throw CurveError.parsePubkeyError }
        if !(secp256k1_ec_pubkey_tweak_add(ctx, &pubkey, tweak.bytes)) { throw CurveError.tweakAddPubkeyError }
        var serializedPubkey = [UInt8](repeating: 0, count:33)
        var length = UInt(33)
        if !(secp256k1_ec_pubkey_serialize(ctx, &serializedPubkey, &length, pubkey, [SECP256K1_FLAGS.SECP256K1_EC_COMPRESSED])) { throw CurveError.serializePubkeyError }
        return serializedPubkey.data
    }
    
    func parsePubkey(_ publicKey: Data) throws -> secp256k1_pubkey {
        guard let ctx = self.context else { throw CurveError.contextError }
        var pubkey = secp256k1_pubkey()
        if !secp256k1_ec_pubkey_parse(ctx, &pubkey, publicKey.bytes, UInt(publicKey.count)) { throw CurveError.parsePubkeyError }
        return pubkey
    }
    
    func getPubkeyForPrivateKey(_ hexPrivateKey: String) throws -> secp256k1_pubkey {
        guard let ctx = self.context else { throw CurveError.contextError }
        let privateKey = hexPrivateKey.unhexlify()
        var pubkey = secp256k1_pubkey()
        if !(secp256k1_ec_pubkey_create(ctx, &pubkey, privateKey)) { throw CurveError.createPubkeyError }
        return pubkey
    }
    
    func generatePublicKey(privateKey: Data, compressed: Bool = true) throws -> Data {
        guard let ctx = self.context else { throw CurveError.contextError }
        var pubkey = secp256k1_pubkey()
        if !(secp256k1_ec_pubkey_create(ctx, &pubkey, privateKey.bytes)) { throw CurveError.createPubkeyError }
        var size: UInt = compressed ? 33 : 65
        var serializedPubkey = [UInt8](repeating: 0, count: Int(size))
        let flag = compressed ? SECP256K1_FLAGS.SECP256K1_EC_COMPRESSED : SECP256K1_FLAGS.SECP256K1_EC_UNCOMPRESSED
        if !(secp256k1_ec_pubkey_serialize(ctx, &serializedPubkey, &size, pubkey, flag)) { throw CurveError.serializePubkeyError }
        return serializedPubkey.data
    }
    
    func sign(key: [UInt8], message: [UInt8]) throws -> (r: Data, s: Data) {
        guard let ctx = self.context else { throw CurveError.contextError }
        var signature = secp256k1_ecdsa_signature()
        // TODO: noncefp uses secp256k1_nonce_function_default when set to nil
        guard secp256k1_ecdsa_sign(ctx, &signature, message, key, nil, nil) == true else { throw CurveError.signingError }
        let r = [UInt8](signature.data[0..<32])
        let s = [UInt8](signature.data[32..<64])
        return (r: r.data, s: s.data)
    }
    
    func sign(key: [UInt8], message: [UInt8]) throws -> secp256k1_ecdsa_signature {
        guard let ctx = self.context else { throw CurveError.contextError }
        var signature = secp256k1_ecdsa_signature()
        // TODO: noncefp uses secp256k1_nonce_function_default when set to nil
        guard secp256k1_ecdsa_sign(ctx, &signature, message, key, nil, nil) == true else { throw CurveError.signingError }
        return signature
    }
    
    func encodeDER(signature: secp256k1_ecdsa_signature) throws -> [UInt8] {
        guard let ctx = self.context else { throw CurveError.contextError }
        let sig = signature
        // add 7 bytes to account for various encoding bytes
        var length = UInt(sig.data.count + 7)
        var output = [UInt8](repeating: 0, count:Int(length))
        guard secp256k1_ecdsa_signature_serialize_der(ctx, &output, &length, sig) else { throw CurveError.derSerializationError }
        return output
    }
    
    // TODO: Decode scriptPubKey to get pubkey, and move or make private func.
    func appendDERbytes(encodedDERSig: [UInt8], hashType: UInt8, scriptPubKey: [UInt8], pubkey: [UInt8]) -> [UInt8] {
        var output = encodedDERSig
        output.append(hashType)
        let derLengthByte: UInt8 = UInt8(output.count)
        output.insert(derLengthByte, at: 0)
        // TODO: Account for other scripts.
        let scriptPubKeyCheck = [UInt8](scriptPubKey[0..<3]).data.hexDescription()
        if scriptPubKeyCheck == "76a914" {
            output.append(UInt8(pubkey.count))
            output += pubkey
        }
        return output
    }
}

extension BTCCurve {
    public enum CurveError: LocalizedError {
        case contextError
        case tweakMulPubkeyError
        case tweakAddPubkeyError
        case serializePubkeyError
        case parsePubkeyError
        case createPubkeyError
        case signingError
        case derSerializationError
    }
}
