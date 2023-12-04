// MnemonicViewModel.swift

import Foundation

@MainActor class MnemonicViewModel: ObservableObject {
    @Published var words = [String](repeating: "", count: 12)
    @Published var isNewWallet = true
    @Published var shouldQuiz = false
    var wallets: [Wallet] = []
    var wallet: Wallet?

    private var validMnemonic: Bool {
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

    init(wallets: [Wallet], currentWallet: String) {
        self.wallets = wallets
        self.wallet = Wallet(name: currentWallet)
    }

    func saveWord(word: String, index: Int) {
        words[index] = word
    }

    func saveWallet() {
        if validMnemonic {
            let mnemonic = words.map { $0.lowercased() }.joined(separator: " ")
            wallet?.mnemonic = mnemonic
            if let wallet = wallet {
                let encoder = JSONEncoder()
                wallets += [wallet]
                if let encodedWallets = try? encoder.encode(wallets) {
                    UserDefaults.standard.set(encodedWallets, forKey: "wallets")
                }
            }
        }
    }

    func randomlyGenerateSeed() {
        let mnemonic = Mnemonic.createRandom()
        words = mnemonic.components(separatedBy: " ")
        shouldQuiz = true
    }
}
