// QuizView.swift

import SwiftUI

struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: QuizViewModel

    var body: some View {
        VStack {
            Text("What is word #\(viewModel.wordIndex + 1)")
                .padding()
            Button("\(viewModel.word1)") {
                viewModel.selected(index: 1) { dismiss in
                    if dismiss {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .frame(width: 150, height: 50)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("btcOrange"), lineWidth: 5)
            }
            .padding()

            Button("\(viewModel.word2)") {
                viewModel.selected(index: 2) { dismiss in
                    if dismiss {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .frame(width: 150, height: 50)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("btcOrange"), lineWidth: 5)
            }
            .padding()
            
            Button("\(viewModel.word3)") {
                viewModel.selected(index: 3) { dismiss in
                    if dismiss {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .frame(width: 150, height: 50)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("btcOrange"), lineWidth: 5)
            }
            .padding()
        }
    }
}
