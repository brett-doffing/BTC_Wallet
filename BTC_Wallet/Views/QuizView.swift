// QuizView.swift

import SwiftUI

struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: QuizViewModel

    init(words: [String], dismissMnemonicView: @escaping (Bool) -> ()) {
        _viewModel = StateObject(wrappedValue: QuizViewModel(
                        words: words,
                        dismissMnemonicView: dismissMnemonicView
                     ))
    }

    var body: some View {
        VStack {
            Text(String(format: NSLocalizedString("wordQuestion %@", comment: ""), "\(viewModel.wordIndex + 1)"))
                .padding()

            ForEach(0..<3) { index in
                getPossibleAnswer(at: index)
            }
        }
    }

    private func getPossibleAnswer(at index: Int) -> some View {
        var word: String
        switch index {
        case 0:
            word = viewModel.word1
        case 1:
            word = viewModel.word2
        default:
            word = viewModel.word3
        }

        return ButtonX(text: "\(word)") {
            viewModel.selected(index + 1, dismissViews)
        }
        .buttonStyle(SecondaryButton())
    }

    private func dismissViews(dismissMenmonicView: Bool) {
        presentationMode.wrappedValue.dismiss()
        
        if dismissMenmonicView {
            viewModel.dismissMnemonicView(dismissMenmonicView)
        }
    }
}
