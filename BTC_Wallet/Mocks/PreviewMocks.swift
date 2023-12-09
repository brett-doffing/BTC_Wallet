// PreviewMocks.swift

import Foundation

struct PreviewMocks {
    static let tx1 = TX(
        blockHeight: 2475370,
        blockTime: 1693262081,
        confirmed: true,
        fee: 22500,
        id: "9ed37b4f54ca4b3450d5ff8b1bd428602f075260c496a045fa313d93fd0041d4",
        locktime: 2475369,
        size: 225,
        version: 2,
        weight: 900,
        v_in: [],
        v_out: [
            V_out(
                scriptpubkey: "76a914b7afbecbf60c64cbf31371a5102aa9d3a39fbf4388ac",
                scriptpubkey_asm: "OP_DUP OP_HASH160 OP_PUSHBYTES_20 b7afbecbf60c64cbf31371a5102aa9d3a39fbf43 OP_EQUALVERIFY OP_CHECKSIG",
                scriptpubkey_address: "mxGCVA2fbK3oih6zHjt4aVVQeC11ZymBsw",
                scriptpubkey_type: "p2pkh",
                value: 1983592,
                isTXO: true,
                isChange: nil,
                isSpent: nil,
                txid: "9ed37b4f54ca4b3450d5ff8b1bd428602f075260c496a045fa313d93fd0041d4"
            )
        ]
    )

    static let tx2 = TX(
        blockHeight: 2475370,
        blockTime: 1693262081,
        confirmed: false,
        fee: 22500,
        id: "9ed37b4f54ca4b3450d5ff8b1bd428602f075260c496a045fa313d93fd0041d4",
        locktime: 2475369,
        size: 225,
        version: 2,
        weight: 900,
        v_in: [],
        v_out: [
            V_out(
                scriptpubkey: "76a914b7afbecbf60c64cbf31371a5102aa9d3a39fbf4388ac",
                scriptpubkey_asm: "OP_DUP OP_HASH160 OP_PUSHBYTES_20 b7afbecbf60c64cbf31371a5102aa9d3a39fbf43 OP_EQUALVERIFY OP_CHECKSIG",
                scriptpubkey_address: "mxGCVA2fbK3oih6zHjt4aVVQeC11ZymBsw",
                scriptpubkey_type: "p2pkh",
                value: 1983592,
                isTXO: true,
                isChange: nil,
                isSpent: true,
                txid: "9ed37b4f54ca4b3450d5ff8b1bd428602f075260c496a045fa313d93fd0041d4"
            )
        ]
    )

    static let txs = [tx1, tx2]
}
