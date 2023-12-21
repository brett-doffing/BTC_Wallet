// MnemonicView.swift

import SwiftUI

struct MnemonicView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = MnemonicViewModel()
    @FocusState private var focusedField: Int?
    let numColumns = 3

    var body: some View {
        VStack {
            wordsView

            VStack {
                if viewModel.shouldQuiz {
                    Text("writeDownMnemonic")
                        .padding()
                    Spacer()
                    quizButton
                } else if viewModel.isNewWallet {
                    Spacer()
                    mnemonicButtons
                }
            }
            .animation(.easeInOut, value: viewModel.shouldQuiz)

            Spacer()
        }
        .toolbar {
            navBarReplacement
        }
        .navigationBarBackButtonHidden(true)
        .alert("Are you sure?", isPresented: $viewModel.showAlert) {
            Button("Go Back", role: .destructive, action: {
                presentationMode.wrappedValue.dismiss()
            })
            Button("cancel", role: .cancel, action: {})
        } message: {
            Text("You will lose the generated seed if you go back without taking the quiz.")
        }

    }

    private func mnemonicWordView(at index: Int) -> some View {
        let word = $viewModel.words[index]
        return MnemonicWordView(
            index: index,
            word: word,
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
        .disabled(!viewModel.isNewWallet)
    }

    private var wordsView: some View {
        ForEach(0..<4) { i in
            HStack {
                ForEach(0..<3) { j in
                    mnemonicWordView(at: (i * numColumns) + j)
                }
            }
        }
        .padding()
    }

    private var mnemonicButtons: some View {
        VStack {
            ButtonX(text: "generateRandomSeed") {
                viewModel.randomlyGenerateSeed()
            }
            .buttonStyle(SecondaryButton())

            ButtonX(text: "save") {
                if viewModel.hasValidMnemonic {
                    viewModel.saveMnemonic()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .buttonStyle(PrimaryButton())
        }
    }

    private var quizButton: some View {
        NavigationLink("quiz", destination: {
            QuizView(words: viewModel.words) { dismiss in
                if dismiss {
                    viewModel.shouldQuiz = false
                    viewModel.saveMnemonic()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        })
        .buttonStyle(PrimaryButton())
    }

    private var navBarReplacement: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            HStack(spacing: 5) {
                Image(systemName: "chevron.left")
                    .fontWeight(.semibold)
                Button("Back") {
                    if viewModel.shouldQuiz {
                        viewModel.showAlert = true
                    } else {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .foregroundColor(Color("btcOrange"))
            .imageScale(.large)
            .font(.system(size: 17))
        }
    }
}

struct MnemonicView_Previews: PreviewProvider {
    static var previews: some View {
        MnemonicView(viewModel: MnemonicViewModel())
    }
}
