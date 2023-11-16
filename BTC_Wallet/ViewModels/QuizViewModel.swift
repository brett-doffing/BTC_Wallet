// QuizViewModel.swift

import Foundation

@MainActor class QuizViewModel: ObservableObject {
    let words: [String]
    var wordIndices: [Int] = [] /// Holds indices of questions that have already been asked
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
        wordIndex = getNewWordIndex()
        wordIndices.append(wordIndex)

        generateAnswerOptions()

        #if DEBUG
        print(words[wordIndex]) // answer
        #endif
    }

    /**
     Randomly selects a new word, while also making sure it has not been used previously.

     - Returns: The random int to index the `words` array
     */
    private func getNewWordIndex() -> Int {
        var answerIndex: Int
        repeat {
            answerIndex = Int.random(in: 0..<12)
        } while wordIndices.contains(answerIndex)

        return answerIndex
    }

    /**
     Randomly selects which button will be the answer,
     while ensuring that no other buttons can be the answer.
     */
    private func generateAnswerOptions() {
        /// Select random button that will be the answer
        answerButtonNumber = Int.random(in: 1...3)
        /// Indices that shouldn't be repeated as possible options for answers
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
    }

    /**
     Action taken when an answer button has been tapped.
     Generate a new question if less than 4 questions have been asked,
     or dismisses views according to quiz success or failure.

     - Parameters:
        - buttonNumber: which button was selected
        - dismissViews: Callback to both dismiss the quiz view,
                        and potentially the mnemonic view if finished successfully
     */
    func selected(_ buttonNumber: Int, _ dismissViews: (Bool) -> ()) {
        if buttonNumber == answerButtonNumber {
            if questionNumber < 4 {
                questionNumber += 1
                generateQuestion()
            } else {
                dismissViews(true)
            }
        } else {
            wordIndices = []
            dismissViews(false)
        }
    }
}
