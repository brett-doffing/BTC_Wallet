// MnemonicView.swift

import SwiftUI

struct MnemonicView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: MnemonicViewModel
    @FocusState private var focusedField: Int?
    let numColumns = 3

    var body: some View {
        VStack {
            Text("writeDownMnemonic")
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
                ButtonX(text: "generateRandomSeed") {
                    viewModel.randomlyGenerateSeed()
                }
                .buttonStyle(SecondaryButton())

                ButtonX(text: "save") {
                    viewModel.saveMnemonic()
                }
                .buttonStyle(PrimaryButton())
                .navigationBarBackButtonHidden(false)
            } else if viewModel.shouldQuiz {
                NavigationLink("quiz", destination: {
                    QuizView(
                        viewModel: QuizViewModel(words: viewModel.words) { dismiss in
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
