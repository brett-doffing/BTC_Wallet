// QuizView.swift

import SwiftUI

struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: QuizViewModel

    var body: some View {
        VStack {
            Text(String(format: NSLocalizedString("wordQuestion %@", comment: ""), "\(viewModel.wordIndex + 1)"))
                .padding()
            
            ButtonX(text: "\(viewModel.word1)") {
                viewModel.selected(buttonNumber: 1) { dismissView() }
            }
            .buttonStyle(SecondaryButton())

            ButtonX(text: "\(viewModel.word2)") {
                viewModel.selected(buttonNumber: 2) { dismissView() }
            }
            .buttonStyle(SecondaryButton())

            ButtonX(text: "\(viewModel.word3)") {
                viewModel.selected(buttonNumber: 3) { dismissView() }
            }
            .buttonStyle(SecondaryButton())
        }
    }

    private func dismissView() {
        presentationMode.wrappedValue.dismiss()
    }
}
