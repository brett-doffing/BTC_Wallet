// MnemonicViewModel.swift

import Foundation

@MainActor class MnemonicViewModel: ObservableObject {
    @Published var words = [String](repeating: "", count: 12)
    @Published var isNewWallet = true
    @Published var shouldQuiz = false
    @Published var showAlert = false
    let store = DataStore.shared
    var wallet: Wallet? {
        get { store.currentWallet }
        set { store.currentWallet = newValue }
    }

    var hasValidMnemonic: Bool {
        let wordSet = WordList.english.wordSet
        for word in words {
            if !wordSet.contains(word) {
                return false
            }
        }
        return true
    }

    init() {
        if let wallet = wallet, let words = wallet.mnemonic?.components(separatedBy: " ") {
            self.words = words
            self.isNewWallet = false
        }
    }

    func saveWord(word: String, index: Int) {
        words[index] = word
    }

    func saveMnemonic() {
        let mnemonic = words.map { $0.lowercased() }.joined(separator: " ")
        wallet?.mnemonic = mnemonic
        store.saveNewWallet()
    }

    func randomlyGenerateSeed() {
        let mnemonic = Mnemonic.createRandom()
        words = mnemonic.components(separatedBy: " ")
        shouldQuiz = true
    }
}
