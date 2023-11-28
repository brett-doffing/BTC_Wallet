// Base58Tests.swift

import XCTest
@testable import BTC_Wallet

final class Base58Tests: XCTestCase {
    
    func test_Base58_checkDecode() {
        let privateKeys = [
            "5JaTXbAUmfPYZFRwrYaALK48fN6sFJp4rHqq2QSXs8ucfpE4yQU",
            "5Jb7fCeh1Wtm4yBBg3q3XbT6B525i17kVhy3vMC9AqfR6FH2qGk",
            "5JFjmGo5Fww9p8gvx48qBYDJNAzR9pmH5S389axMtDyPT8ddqmw"
        ]
        let decodedHexKeys = [
            "80644bf9f55770be3abe48945519209dadbc4256d65ad88d542f8fbe26247f398d",
            "8065ca213e0fdeedf32c25727bd6b30045549b8d3eccad7cf1ba56c880b1abcd8d",
            "8039ca62fd663f7106da291666f916baf93076a59046004f4dc4eaf4d5085d9f6b"
        ]

        for i in 0..<3 {
            // Given
            let privateKey = privateKeys[i]
            // When
            let decodedKey = privateKey.base58CheckDecode()
            // Then
            XCTAssertEqual(decodedKey!.hexDescription(), decodedHexKeys[i])

        }
    }

    func test_Base58_checkEncodedString() {
        // Given
        let data = "05f815b036d9bbbce5e9f2a00abd1bf3dc91e95510".hexData()
        // When
        let checkEncodedString = data!.base58CheckEncodedString
        // Then
        XCTAssertEqual(checkEncodedString, "3QJmV3qfvL9SuYo34YihAf3sRCW3qSinyC")
    }

    func test_Base58_encodedString() {
        // Given
        let data = "0488ade4000000000000000000873dff81c02f525623fd1fe5167eac3a55a049de3d314bb42ee227ffed37d50800e8f32e723decf4051aefac8e2c93c9c5b214313817cdb01a1494b917c8436b35e77e9d71".hexData()
        // When
        let encodedString = data!.base58EncodedString()
        // Then
        XCTAssertEqual(encodedString, "xprv9s21ZrQH143K3QTDL4LXw2F7HEK3wJUD2nW2nRk4stbPy6cq3jPPqjiChkVvvNKmPGJxWUtg6LnF5kejMRNNU3TGtRBeJgk33yuGBxrMPHi")
    }
}
