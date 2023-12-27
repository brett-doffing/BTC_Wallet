// TransactionTests.swift

import XCTest
@testable import BTC_Wallet

final class TransactionTests: XCTestCase {

    func testOneInOneOutTestnetTx() {
        // Given
        let utxo = V_out(
            scriptpubkey: "76a9146ff4536d48becdc2f9cf55f4f34d7f0b268dc83f88ac",
            scriptpubkey_asm: "",
            scriptpubkey_address: "mqiuzQahssG6YzDmd8t9A3oXtpi9uFAdnQ",
            value: 919423,
            n: 0,
            txid: "c291228357e8927c4c35b3211401e3a2e26b680a9ff5215eddd6aaf2310b3f32"
        )
        let addressArray = ["mwyTfAfJSNAA3xMCxrSWa71qXe7C7ByuSF"]
        let satoshisArray = [UInt64(909423)]
        var privateKey = "cNM2T9Qd2cCuNrJMPL9X83R8dFWJd6rugZthJqjJes2MpjZCS5Qm".base58CheckDecode()!
        privateKey.removeFirst(); privateKey.removeLast()
        // When
        let transaction = Transaction(
            receivingAddresses: addressArray,
            satoshisArray: satoshisArray,
            utxos: [utxo],
            _privateKeys: [privateKey]
        )
        // Then
        XCTAssertEqual(transaction.rawTX!.hexDescription(), "0100000001323f0b31f2aad6dd5e21f59f0a686be2a2e3011421b3354c7c92e857832291c2000000006b483045022100ce4de81af40c58836c0a62dc252c1a4832de6cd24f98ba333271d51c18be7a1f02204c5f45afc69ecb38948c9217959bb2b19f9859e4f6c81abd455790488557e561012103a7ff20231eecf4c67c019b329f8958a686510e1922ad2b37957424b02fd240eaffffffff016fe00d00000000001976a914b48556e2de495803e21ec650de6c07bfb35e252c88ac00000000")
    }
}
