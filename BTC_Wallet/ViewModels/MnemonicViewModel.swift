// MnemonicViewModel.swift

import Foundation

class MnemonicViewModel: ObservableObject {
    @Published var words = [String](repeating: "", count: 12)
    @Published var hasMnemonic = false
    @Published var shouldQuiz = false
    var wallets: [[String: String]] = []
    var walletName: String?

    init(_ walletName: String? = nil) {
        self.walletName = walletName
        checkForMnemonic()
    }

    func checkForMnemonic() {
        if let wallets = UserDefaults.standard.object(forKey: "wallets") as? [[String: String]] {
            self.wallets = wallets
            for wallet in wallets {
                if let name = wallet["name"], name == walletName, let mnemonic = wallet["mnemonic"] {
                    words = mnemonic.components(separatedBy: " ")
                    hasMnemonic = true
                }
            }
        }
    }

    func saveWord(word: String, index: Int) {
        words[index] = word
    }

    func saveMnemonic() {
        if validateMnemonic() {
            let mnemonic = words.map { $0.lowercased() }.joined(separator: " ")
            UserDefaults.standard.set(mnemonic, forKey: "mnemonic")
            shouldQuiz = true
        }
    }

    private func validateMnemonic() -> Bool {
        for word in words {
            if !WordList.english.words.contains(word) {
                return false
            }
        }
        return true
    }

    func randomlyGenerateSeed() {
        let mnemonic = Mnemonic.createRandom()

        if let name = walletName {
            wallets += [["name": name, "mnemonic": mnemonic]]
            UserDefaults.standard.set(wallets, forKey: "wallets")
        }

        // TODO: Save Securely
//            let kcpi = KeychainPasswordItem(service: "wallet", account: "satoshi")
//            do { try kcpi.savePassword(mnemonic) }
//            catch let kcError {
//                print("error = \(kcError)")
//                isLoading = false
//                return
//            }
        checkForMnemonic()
        shouldQuiz = true
    }
}
