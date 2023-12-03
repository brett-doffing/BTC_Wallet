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

            wordsView

            Spacer()

            if viewModel.shouldQuiz {
                quizButton
            } else {
                mnemonicButtons
            }

            Spacer()
        }
        .onAppear { viewModel.checkForMnemonic() }
    }

    var wordsView: some View {
        ForEach(0..<4) { i in
            HStack {
                ForEach(0..<3) { j in
                    getMnemonicWordView(at: i, and: j)
                }
            }
        }
        .padding()
    }

    var mnemonicButtons: some View {
        VStack {
            ButtonX(text: "generateRandomSeed") {
                viewModel.randomlyGenerateSeed()
            }
            .buttonStyle(SecondaryButton())

            ButtonX(text: "save") {
                viewModel.saveMnemonic()
            }
            .buttonStyle(PrimaryButton())
            .navigationBarBackButtonHidden(false)
        }
    }

    var quizButton: some View {
        NavigationLink("quiz", destination: {
            QuizView(words: viewModel.words) { dismiss in
                if dismiss {
                    viewModel.shouldQuiz = false
                    presentationMode.wrappedValue.dismiss()
                }
            }
        })
        .buttonStyle(PrimaryButton())
        .navigationBarBackButtonHidden(true)
    }

    func getMnemonicWordView(at i: Int, and j: Int) -> some View {
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
