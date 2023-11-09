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
                viewModel.selected(index: 1) { dismiss in
                    if dismiss { dismissView() }
                }
            }
            .padding()

            ButtonX(text: "\(viewModel.word2)") {
                viewModel.selected(index: 2) { dismiss in
                    if dismiss { dismissView() }
                }
            }
            .padding()
            
            ButtonX(text: "\(viewModel.word3)") {
                viewModel.selected(index: 3) { dismiss in
                    if dismiss { dismissView() }
                }
            }
            .padding()
        }
    }

    private func dismissView() {
        presentationMode.wrappedValue.dismiss()
    }
}
