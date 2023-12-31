// BTCKeychainType.swift

import Foundation

public enum BTCKeychainType: Codable {
    case master
    case derived
    case BIP44
    case BIP47
    case BIP49
    case BIP84
}
