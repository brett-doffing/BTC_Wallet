// Base58Tests.swift

import XCTest
@testable import BTC_Wallet

final class Base58Tests: XCTestCase {
    func test_Base58_CheckDecode() {
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
}
