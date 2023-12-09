// MnemonicView.swift

import SwiftUI

struct MnemonicView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var wallets: Wallets
    @StateObject var viewModel: MnemonicViewModel
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
            ToolbarItem(placement: .navigationBarLeading) {
                HStack(spacing: 5) {
                    Image(systemName: "chevron.left")
                        .fontWeight(.semibold)
                    Button("Back") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .foregroundColor(Color("btcOrange"))
                .imageScale(.large)
                .font(.system(size: 17))
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    var wordsView: some View {
        ForEach(0..<4) { i in
            HStack {
                ForEach(0..<3) { j in
                    getMnemonicWordView(at: (i * numColumns) + j)
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
                if viewModel.hasValidMnemonic {
                    viewModel.saveMnemonic()
                    wallets.save(viewModel.wallet)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .buttonStyle(PrimaryButton())
//            .navigationBarBackButtonHidden(false)
        }
    }

    var quizButton: some View {
        NavigationLink("quiz", destination: {
            QuizView(words: viewModel.words) { dismiss in
                if dismiss {
                    viewModel.shouldQuiz = false
                    viewModel.saveMnemonic()
                    wallets.save(viewModel.wallet)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        })
        .buttonStyle(PrimaryButton())
//        .navigationBarBackButtonHidden(true)
    }

    func getMnemonicWordView(at index: Int) -> some View {
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
        .padding(5)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(lineWidth: 1)
        }
        .disabled(!viewModel.isNewWallet)
    }
}

struct MnemonicView_Previews: PreviewProvider {
    static var previews: some View {
        MnemonicView(viewModel: MnemonicViewModel(currentWallet: ""))
    }
}
