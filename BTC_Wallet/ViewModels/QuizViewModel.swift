// QuizViewModel.swift

import Foundation

@MainActor class QuizViewModel: ObservableObject {
    let words: [String]
    /// Holds indices of question that have already been asked
    var wordIndices: [Int] = []
    var answerButtonNumber = 0
    var questionNumber = 1
    let dismissMnemonicView: (Bool) -> ()
    @Published var wordIndex: Int = 0
    @Published var word1: String = ""
    @Published var word2: String = ""
    @Published var word3: String = ""

    init(words: [String], dismissMnemonicView: @escaping (Bool) -> ()) {
        self.words = words
        self.dismissMnemonicView = dismissMnemonicView
        self.generateQuestion()
    }

    /**
     Generates the question, answer, and two wrong answers, making sure not to repeat or duplicate answers or questions.
     */
    private func generateQuestion() {
        /// Index for answer to question
        repeat {
            wordIndex = Int.random(in: 0..<12)
        } while wordIndices.contains(wordIndex)
        wordIndices.append(wordIndex)

        /// Random button will be the answer
        answerButtonNumber = Int.random(in: 1...3)

        /// Indices that shouldn't be repeated as possible answer options
        var answerIndices: [Int] = []

        for i in 1...3 {
            var idx = wordIndex
            if i != answerButtonNumber {
                var randomIdx = Int.random(in: 0..<12)
                while randomIdx == wordIndex || answerIndices.contains(randomIdx) {
                    randomIdx = Int.random(in: 0..<12)
                }
                idx = randomIdx
            }
            answerIndices.append(idx)

            switch i {
            case 1:
                word1 = words[idx]
            case 2:
                word2 = words[idx]
            default:
                word3 = words[idx]
            }
        }
        #if DEBUG
        print(words[wordIndex]) // answer
        #endif
    }

    /**
     Action taken when an answer button has been tapped.
     */
    func selected(buttonNumber: Int, dismissQuizView: () -> ()) {
        if buttonNumber == answerButtonNumber {
            if questionNumber < 4 {
                questionNumber += 1
                generateQuestion()
            } else {
                dismissQuizView()
                dismissMnemonicView(true)
            }
        } else {
            wordIndices = []
            dismissQuizView()
            dismissMnemonicView(false)
        }
    }
}
