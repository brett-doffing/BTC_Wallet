// QuizViewModel.swift

import Foundation

extension QuizView {
    @MainActor class QuizViewModel: ObservableObject {
        let words: [String]
        var answerButtonIndex = 0
        @Published var wordIndex: Int = 1
        @Published var word1: String = ""
        @Published var word2: String = ""
        @Published var word3: String = ""

        init(words: [String]) {
            self.words = words
            self.generateQuiz()
        }

        func generateQuiz() {
            // Index for answer to question
            wordIndex = Int.random(in: 0..<12)
            // Random button will be the answer
            answerButtonIndex = Int.random(in: 1...3)
            // Indecies that shouldn't be repeated as possible answer options
            var takenIndecies: [Int] = []

            for i in 1...3 {
                var idx = wordIndex
                if i != answerButtonIndex {
                    var randomIdx = Int.random(in: 0..<12)
                    while randomIdx == wordIndex || takenIndecies.contains(randomIdx) {
                        randomIdx = Int.random(in: 0..<12)
                    }
                    idx = randomIdx
                }
                takenIndecies.append(idx)

                switch i {
                case 1:
                    word1 = words[idx]
                case 2:
                    word2 = words[idx]
                default:
                    word3 = words[idx]
                }
            }
            print(words[wordIndex])
        }

        func selected(index: Int) {
            if index == answerButtonIndex {
                print("correct")
                generateQuiz()
            } else {
                print("wrong")
            }
        }
    }
}
