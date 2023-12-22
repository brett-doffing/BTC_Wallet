// PreviewMocks.swift

import Foundation

struct PreviewMocks {
    static let tx1 = TX(
        blockHeight: 2475370,
        blockTime: 1693262081,
        confirmed: true,
        fee: 22500,
        id: "9ed37b4f54ca4b3450d5ff8b1bd428602f075260c496a045fa313d93fd0041d1",
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
        id: "9ed37b4f54ca4b3450d5ff8b1bd428602f075260c496a045fa313d93fd0041d2",
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

    static let tx3 = TX(
        blockHeight: 2475370,
        blockTime: 1693262081,
        confirmed: false,
        fee: 22500,
        id: "9ed37b4f54ca4b3450d5ff8b1bd428602f075260c496a045fa313d93fd0041d3",
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

    static let tx4 = TX(
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

    static let tx5 = TX(
        blockHeight: 2475370,
        blockTime: 1693262081,
        confirmed: false,
        fee: 22500,
        id: "9ed37b4f54ca4b3450d5ff8b1bd428602f075260c496a045fa313d93fd0041d5",
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

    static let tx6 = TX(
        blockHeight: 2475370,
        blockTime: 1693262081,
        confirmed: false,
        fee: 22500,
        id: "9ed37b4f54ca4b3450d5ff8b1bd428602f075260c496a045fa313d93fd0041d6",
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

    static let tx7 = TX(
        blockHeight: 2475370,
        blockTime: 1693262081,
        confirmed: false,
        fee: 22500,
        id: "9ed37b4f54ca4b3450d5ff8b1bd428602f075260c496a045fa313d93fd0041d7",
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

    static let tx8 = TX(
        blockHeight: 2475370,
        blockTime: 1693262081,
        confirmed: false,
        fee: 22500,
        id: "9ed37b4f54ca4b3450d5ff8b1bd428602f075260c496a045fa313d93fd0041d8",
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

    static let tx9 = TX(
        blockHeight: 2475370,
        blockTime: 1693262081,
        confirmed: false,
        fee: 22500,
        id: "9ed37b4f54ca4b3450d5ff8b1bd428602f075260c496a045fa313d93fd0041d9",
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

    static let tx0 = TX(
        blockHeight: 2475370,
        blockTime: 1693262081,
        confirmed: false,
        fee: 22500,
        id: "9ed37b4f54ca4b3450d5ff8b1bd428602f075260c496a045fa313d93fd0041d0",
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

//    static let wallet0 = Wallet(transactions: [tx0, tx1, tx2, tx3, tx4])
//    static let wallet0 = Wallet(transactions: [tx5, tx6, tx7])
//    static let wallet0 = Wallet(transactions: [tx8, tx9])
}
