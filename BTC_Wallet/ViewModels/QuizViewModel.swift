// QuizViewModel.swift

import Foundation

extension QuizView {
    @MainActor class QuizViewModel: ObservableObject {
        let words: [String]
        /// Holds indices that have been questioned
        var wordIndices: [Int] = []
        var answerButtonIndex = 0
        var questionCounter = 0
        let callback: (Bool) -> ()
        @Published var wordIndex: Int = 0
        @Published var word1: String = ""
        @Published var word2: String = ""
        @Published var word3: String = ""

        init(words: [String], callback: @escaping (Bool) -> ()) {
            self.words = words
            self.callback = callback
            self.generateQuiz()
        }

        func generateQuiz() {
            questionCounter += 1
            
            // Index for answer to question
            repeat {
                wordIndex = Int.random(in: 0..<12)
            } while wordIndices.contains(wordIndex)
            wordIndices.append(wordIndex)

            // Random button will be the answer
            answerButtonIndex = Int.random(in: 1...3)

            // Indecies that shouldn't be repeated as possible answer options
            var takenIndices: [Int] = []

            for i in 1...3 {
                var idx = wordIndex
                if i != answerButtonIndex {
                    var randomIdx = Int.random(in: 0..<12)
                    while randomIdx == wordIndex || takenIndices.contains(randomIdx) {
                        randomIdx = Int.random(in: 0..<12)
                    }
                    idx = randomIdx
                }
                takenIndices.append(idx)

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

        func selected(index: Int, dismiss: () -> ()) {
            if index == answerButtonIndex {
                if questionCounter < 4 {
                    generateQuiz()
                } else {
                    dismiss()
                    callback(true)
                }
            } else {
                wordIndices = []
                dismiss()
                callback(false)
            }
        }
    }
}
