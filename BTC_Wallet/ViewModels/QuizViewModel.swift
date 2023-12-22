// QuizViewModel.swift

import Foundation

class QuizViewModel: ObservableObject {
    @Published var wordIndex: Int = -1
    @Published var word1: String = ""
    @Published var word2: String = ""
    @Published var word3: String = ""
    
    private let words: [String]
    private var answers: [(Int, String)] = []
    private var wrongAnswerOptions: [String] = []
    private var answerButtonNumber = 0
    private var questionNumber = 1

    let dismissMnemonicView: (Bool) -> ()

    init(words: [String], dismissMnemonicView: @escaping (Bool) -> ()) {
        self.words = words
        self.dismissMnemonicView = dismissMnemonicView

        generateQuiz()
        generateQuestion()
    }

    func generateQuiz() {
        guard words.count == 12 else { return }
        var wordsEnumerated: [(index: Int, word: String)] = []
        for (i, word) in words.enumerated() {
            wordsEnumerated.append((i, word))
        }

        for _ in 0...3 {
            let index = Int.random(in: 0..<wordsEnumerated.count)
            let answer = wordsEnumerated.remove(at: index)
            answers.append(answer)
        }
        wrongAnswerOptions = wordsEnumerated.shuffled().map { $0.word }
    }

    private func generateQuestion() {
        guard wrongAnswerOptions.count >= 2 else { return }
        answerButtonNumber = Int.random(in: 1...3)

        for i in 1...3 {
            var word: String
            if i != answerButtonNumber {
                word = wrongAnswerOptions.removeLast()
            } else {
                let answer = answers.removeLast()
                wordIndex = answer.0 // index
                word = answer.1 // word

                #if DEBUG
                print(word) // answer
                #endif
            }

            switch i {
            case 1:
                word1 = word
            case 2:
                word2 = word
            default:
                word3 = word
            }
        }
    }

    /**
     Action taken when an answer button has been tapped.

     Generate a new question if less than 4 questions have been asked,
     or dismisses views according to quiz success or failure.

     - Parameters:
        - buttonNumber: which button was selected
        - dismissViews: Callback to dismiss both the quiz view,
                        and potentially the mnemonic view if finished successfully.
                        The boolean value designates whether both should be dismissed.
     */
    func selected(_ buttonNumber: Int, _ dismissViews: (Bool) -> ()) {
        assert((buttonNumber != 0 && buttonNumber <= 3), "Invalid button number")
        if buttonNumber == answerButtonNumber {
            if questionNumber < 4 {
                questionNumber += 1
                generateQuestion()
            } else {
                dismissViews(true)
            }
        } else {
            dismissViews(false)
        }
    }
}
