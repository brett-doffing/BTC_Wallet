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

    func testTwoInTwoOutTestnetTx() {
        // Given
        let utxo1 = V_out(
            scriptpubkey: "210229688a74abd0d5ad3b06ddff36fa9cd8edd181d97b9489a6adc40431fb56e1d8ac",
            scriptpubkey_asm: "",
            scriptpubkey_address: "n2KprMQm4z2vmZnPMENfbp2P1LLdAEFRjS",
            value: 5000000000,
            n: 0,
            txid: "78203a8f6b529693759e1917a1b9f05670d036fbb129110ed26be6a36de827f3"
        )
        let utxo2 = V_out(
            scriptpubkey: "76a9149ba386253ea698158b6d34802bb9b550f5ce36dd88ac",
            scriptpubkey_asm: "",
            scriptpubkey_address: "muhtvdmsnbQEPFuEmxcChX58fGvXaaUoVt",
            value: 4000000000,
            n: 0,
            txid: "263c018582731ff54dc72c7d67e858c002ae298835501d80200f05753de0edf0"
        )

        let addressArray = ["n4puhBEeEWD2VvjdRC9kQuX2abKxSCMNqN", "n4LWXU59yM5MzQev7Jx7VNeq1BqZ85ZbLj"]
        let satoshisArray = [UInt64(7999990000), UInt64(1000000000)]
        var privateKey1 = "cSp57iWuu5APuzrPGyGc4PGUeCg23PjenZPBPoUs24HtJawccHPm".base58CheckDecode()!
        var privateKey2 = "cT26DX6Ctco7pxaUptJujRfbMS2PJvdqiSMaGaoSktHyon8kQUSg".base58CheckDecode()!
        privateKey1.removeFirst(); privateKey1.removeLast(); privateKey2.removeFirst(); privateKey2.removeLast()

        // When
        let transaction = Transaction(
            receivingAddresses: addressArray,
            satoshisArray: satoshisArray,
            utxos: [utxo1, utxo2],
            _privateKeys: [privateKey1, privateKey2]
        )
        // Then
        XCTAssertEqual(transaction.rawTX!.hexDescription(), "0100000002f327e86da3e66bd20e1129b1fb36d07056f0b9a117199e759396526b8f3a20780000000049483045022100ce5dd767430d42a9df1ac88d1bfd04a3fe4cf0ca3241c0bb143e76677528b9f702206f51396eab2c5c808c00d3ce3156774fa9c5b47e7190e6193dc952ab6e89e10c01fffffffff0ede03d75050f20801d50358829ae02c058e8677d2cc74df51f738285013c26000000006b483045022100b14bfacb90c6a4292fd0385ef94671ff26a8f14ab7086a6c1ac1ee6d64ae0cbd02203ed58ef3ef635cec3fc0dde9f7d33a7d9d0029ff7c0260b7bb73364e075add75012102240d7d3c7aad57b68aa0178f4c56f997d1bfab2ded3c2f9427686017c603a6d6ffffffff02f028d6dc010000001976a914ffb035781c3c69e076d48b60c3d38592e7ce06a788ac00ca9a3b000000001976a914fa5139067622fd7e1e722a05c17c2bb7d5fd6df088ac00000000")
    }
}
