// QuizView.swift

import SwiftUI

struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: QuizViewModel

    var body: some View {
        VStack {
            Text("What is word #\(viewModel.wordIndex + 1)")
                .padding()
            
            ButtonX(text: "\(viewModel.word1)") {
                viewModel.selected(buttonNumber: 1) { dismissView() }
            }
            .padding()

            ButtonX(text: "\(viewModel.word2)") {
                viewModel.selected(buttonNumber: 2) { dismissView() }
            }
            .padding()
            
            ButtonX(text: "\(viewModel.word3)") {
                viewModel.selected(buttonNumber: 3) { dismissView() }
            }
            .padding()
        }
    }

    private func dismissView() {
        presentationMode.wrappedValue.dismiss()
    }
}
