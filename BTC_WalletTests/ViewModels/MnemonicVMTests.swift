// MnemonicVMTests.swift

import XCTest
@testable import BTC_Wallet

final class MnemonicVMTests: XCTestCase {
    @MainActor func test_MnemonicViewModel_saveWord() {
        // Given
        let vm = MnemonicViewModel(currentWallet: "")
        let words: [String] = ["legal", "winner", "thank", "year", "wave", "sausage", "worth", "useful", "legal", "winner", "thank", "yellow"]
        // When
        for _ in 0..<24 {
            let randomIndex = Int.random(in: 0..<words.count)
            let word = words[randomIndex]
            vm.saveWord(word: word, index: randomIndex)
            // Then
            XCTAssertTrue(vm.words[randomIndex] == word)
        }
    }

    @MainActor func test_MnemonicViewModel_saveMnemonic() {
        // Given
        let vm = MnemonicViewModel(currentWallet: "")
        let words = ["legal", "winner", "thank", "year", "wave", "sausage", "worth", "useful", "legal", "winner", "thank", "yellow"]
        let mnemonic = words.map { $0.lowercased() }.joined(separator: " ")
        // When
        vm.words = words
        vm.saveMnemonic()
        // Then
        XCTAssertTrue(vm.wallet.mnemonic == mnemonic)
    }

    @MainActor func test_MnemonicViewModel_randomlyGenerateSeed() {
        // Given
        let vm = MnemonicViewModel(currentWallet: "")
        // When
        vm.randomlyGenerateSeed()
        // Then
        XCTAssertTrue(vm.hasValidMnemonic)
        XCTAssertTrue(vm.shouldQuiz)
    }
}
