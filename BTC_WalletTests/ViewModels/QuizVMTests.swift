// QuizVMTests.swift

import XCTest
@testable import BTC_Wallet

final class QuizVMTests: XCTestCase {

    func test_QuizViewModel_words_empty() {
        // Given
        let words: [String] = []
        // When
        let vm = QuizViewModel(words: words, dismissMnemonicView: {_ in })
        // Then
        XCTAssertTrue(vm.word1 == "")
        XCTAssertTrue(vm.word2 == "")
        XCTAssertTrue(vm.word3 == "")
        XCTAssertTrue(vm.wordIndex == -1)
    }

    func test_QuizViewModel_words_sixWords() {
        // Given
        let words: [String] = ["some", "words", "exist", "but", "not", "enough"]
        // When
        let vm = QuizViewModel(words: words, dismissMnemonicView: {_ in })
        // Then
        XCTAssertTrue(vm.word1 == "")
        XCTAssertTrue(vm.word2 == "")
        XCTAssertTrue(vm.word3 == "")
        XCTAssertTrue(vm.wordIndex == -1)
    }

    func test_QuizViewModel_words_twelveWords() {
        // Given
        let words: [String] = ["legal", "winner", "thank", "year", "wave", "sausage", "worth", "useful", "legal", "winner", "thank", "yellow"]
        // When
        let vm = QuizViewModel(words: words, dismissMnemonicView: {_ in })
        // Then
        XCTAssertTrue(vm.word1 != "")
        XCTAssertTrue(vm.word2 != "")
        XCTAssertTrue(vm.word3 != "")
        XCTAssertTrue(vm.wordIndex != -1)
    }
}
