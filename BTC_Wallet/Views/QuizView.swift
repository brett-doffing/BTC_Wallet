// QuizView.swift

import SwiftUI

struct QuizView: View {
    @StateObject var viewModel: QuizViewModel

    var body: some View {
        VStack {
            Text("What is word #\(viewModel.wordIndex + 1)")
                .padding()
            Button("\(viewModel.word1)") {
                viewModel.selected(index: 1)
            }
            .padding()
            Button("\(viewModel.word2)") {
                viewModel.selected(index: 2)
            }
            .padding()
            Button("\(viewModel.word3)") {
                viewModel.selected(index: 3)
            }
            .padding()
        }
    }
}
