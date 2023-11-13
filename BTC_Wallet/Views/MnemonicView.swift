// MnemonicView.swift

import SwiftUI

struct MnemonicView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: MnemonicViewModel
    @FocusState private var focusedField: Int?
    let numColumns = 3

    var body: some View {
        VStack {
            Text("Make sure to write down these words, in order, and store them in a safe place. You will be quizzed once you create them.")
                .padding()

            ForEach(0..<4) { i in
                HStack {
                    ForEach(0..<3) { j in
                        MnemonicWordView(
                            index: ((i * numColumns) + j),
                            words: $viewModel.words,
                            disabled: $viewModel.hasMnemonic,
                            saveWord: { word, index in viewModel.saveWord(word: word, index: index) },
                            focus: $focusedField,
                            nextFocus: { index in
                                if let index = index {
                                    self.focusedField = index + 1
                                } else {
                                    self.focusedField = nil
                                }
                            }
                        )
                        .padding(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .strokeBorder(lineWidth: 1)
                        }
                    }
                }
            }
            .padding()

            Spacer()

            if !viewModel.hasMnemonic {
                ButtonX(text: "Generate Random Seed") {
                    viewModel.randomlyGenerateSeed()
                }
                .buttonStyle(SecondaryButton())

                ButtonX(text: "Save") {
                    viewModel.saveMnemonic()
                }
                .buttonStyle(PrimaryButton())
                .navigationBarBackButtonHidden(false)
            } else if viewModel.shouldQuiz {
                NavigationLink("Quiz", destination: {
                    QuizView(viewModel:
                                QuizViewModel(words: viewModel.words) { dismiss in
                                    if dismiss {
                                        viewModel.shouldQuiz = false
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                    )
                })
                .frame(width: 200, height: 50)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("btcOrange"), lineWidth: 3)
                }
                .navigationBarBackButtonHidden(true)
                .padding()
            }
            Spacer()
        }
        .onAppear { viewModel.checkForMnemonic() }
    }
}
