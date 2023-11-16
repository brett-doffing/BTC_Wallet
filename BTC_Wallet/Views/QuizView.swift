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
            
            ButtonX(text: "\(viewModel.word1)") {
                viewModel.selected(1, dismissViews)
            }
            .buttonStyle(SecondaryButton())

            ButtonX(text: "\(viewModel.word2)") {
                viewModel.selected(2, dismissViews)
            }
            .buttonStyle(SecondaryButton())

            ButtonX(text: "\(viewModel.word3)") {
                viewModel.selected(3, dismissViews)
            }
            .buttonStyle(SecondaryButton())
        }
    }

    private func dismissViews(dismissMenmonicView: Bool) {
        presentationMode.wrappedValue.dismiss()
        
        if dismissMenmonicView {
            viewModel.dismissMnemonicView(dismissMenmonicView)
        }
    }
}
