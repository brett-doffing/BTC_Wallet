// MnemonicViewModel.swift

import Foundation

@MainActor class MnemonicViewModel: ObservableObject {
    @Published var words = [String](repeating: "", count: 12)
    @Published var isNewWallet = true
    @Published var shouldQuiz = false
    @Published var showAlert = false
    var wallet: Wallet

    var hasValidMnemonic: Bool {
        for word in words {
            if !WordList.english.words.contains(word) {
                return false
            }
        }
        return true
    }

    init(_ wallet: Wallet) {
        self.wallet = wallet
        self.isNewWallet = false
        if let words = wallet.mnemonic?.components(separatedBy: " ") {
            self.words = words
        }
    }

    init(currentWallet: String) {
        self.wallet = Wallet(name: currentWallet)
    }

    func saveWord(word: String, index: Int) {
        words[index] = word
    }

    func saveMnemonic() {
        let mnemonic = words.map { $0.lowercased() }.joined(separator: " ")
        wallet.mnemonic = mnemonic
    }

    func randomlyGenerateSeed() {
        let mnemonic = Mnemonic.createRandom()
        words = mnemonic.components(separatedBy: " ")
        shouldQuiz = true
    }
}
