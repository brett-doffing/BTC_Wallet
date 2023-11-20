// QuizVMTests.swift

import XCTest
@testable import BTC_Wallet

final class QuizVMTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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

    func test_QuizViewModel_words_partial() {
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

}
