// MnemonicView.swift

import SwiftUI

struct MnemonicView: View {
    @StateObject var viewModel = MnemonicViewModel()
    @FocusState private var focusedField: Int?
    let numColumns = 3

    var body: some View {
        VStack {
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
            if !viewModel.hasMnemonic {
                Button("Generate Random Seed") {
                    viewModel.randomlyGenerateSeed()
                }
                Text("Make sure to write down these words and store them in a safe place. You will be quizzed once you hit \"SAVE\".")
                    .padding()
                Button("Save") {
                    viewModel.saveMnemonic()
                }
                .frame(width: 150, height: 50)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 5)
                }
                .padding()
            }
        }
        .onAppear { viewModel.checkForMnemonic() }
        Spacer()
    }
}
