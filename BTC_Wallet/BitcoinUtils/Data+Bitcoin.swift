//
//  Data+Bitcoin.swift
//

import Foundation

extension Data {
    /**
     Casts `Data` to a byte array of type `UInt8`.
     */
    public var bytes: [UInt8]
    {
        return [UInt8](self)
    }

    /**
     Performs two hash functions: sha256, then ripemd160.
     */
    func hash160() -> Data {
        let hashedPubkey = self.SHA256()
        let hash160: Data = RIPEMD160.hash(hashedPubkey)
        return hash160
    }
    
    func base58EncodedString() -> String {
        let alphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
        var bytes = self
        var zerosCount = 0
        var length = 0

        // Remove leading zeroes
        for b in bytes {
            if b != 0 { break }
            zerosCount += 1
        }
        
        bytes.removeFirst(zerosCount)
        
        let size = bytes.count * 138 / 100 + 1
        
        var base58: [UInt8] = Array(repeating: 0, count: size)
        for b in bytes {
            var carry = Int(b)
            var i = 0
            
            for j in 0...base58.count-1 where carry != 0 || i < length {
                carry += 256 * Int(base58[base58.count - j - 1])
                base58[base58.count - j - 1] = UInt8(carry % 58)
                carry /= 58
                i += 1
            }
            
            assert(carry == 0)
            
            length = i
        }
        
        // skip leading zeros
        var zerosToRemove = 0
        var str = ""
        for b in base58 {
            if b != 0 { break }
            zerosToRemove += 1
        }
        base58.removeFirst(zerosToRemove)
        
        while 0 < zerosCount {
            str = "\(str)1"
            zerosCount -= 1
        }
        
        for b in base58 {
            str = "\(str)\(alphabet[String.Index(utf16Offset: Int(b), in: alphabet)])"
        }
        
        return str
    }
    
    public var base58CheckEncodedString: String {
        let checksum = self.doubleSHA256().prefix(4)
        let dataPlusChecksum = self + checksum
        return dataPlusChecksum.base58EncodedString()
    }
    
    func XOR(keyData: Data) -> Data {
        var xorData = Data()
        for i in 0..<self.count { xorData += (self[i] ^ keyData[i]) }
        return Data(xorData)
    }
    
}

// TODO: Check to see if already exists in secp256k1.framework
extension Array where Element == UInt8 {
    var data : Data{
        return Data((self))
    }
    
    func bigToLittleEndian() -> [UInt8] {
        var littleEndianArray: [UInt8] = []
        for byte in self {
            littleEndianArray.insert(byte.littleEndian, at: 0)
        }
        return littleEndianArray
    }
}

// MARK: DataConvertable
protocol DataConvertable {
    static func +(lhs: Data, rhs: Self) -> Data
    static func +(lhs: Self, rhs: Data) -> Data
    static func +=(lhs: inout Data, rhs: Self)
}

// FIXME: Struggles with consecutive inline operations such as: OP_0 + UInt8(0x00) + Data.
extension DataConvertable {
    static func +(lhs: Data, rhs: Self) -> Data {
        var value = rhs
        let data = Data(buffer: UnsafeBufferPointer(start: &value, count: 1))
        return lhs + data
    }

    static func +(lhs: Self, rhs: Data) -> Data {
        var value = lhs
        let data = Data(buffer: UnsafeBufferPointer(start: &value, count: 1))
        return data + rhs
    }
    
    static func +=(lhs: inout Data, rhs: Self) {
        lhs = lhs + rhs
    }
}

extension UInt8: DataConvertable {}
extension UInt32: DataConvertable {}
