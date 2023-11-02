// MnemonicViewModel.swift

import Foundation

extension MnemonicView {
    @MainActor class MnemonicViewModel: ObservableObject {
        @Published var words: [String] = []
        @Published var hasMnemonic = false
        @Published var shouldQuiz = false

        init(words: [String]? = nil) {
            checkForMnemonic()
        }

        func checkForMnemonic() {
            if let mnemonic = UserDefaults.standard.object(forKey: "mnemonic") as? String {
                words = mnemonic.components(separatedBy: " ")
                hasMnemonic = true
            } else {
                words = [String](repeating: "", count: 12)
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

            // TODO: Save Securely
            UserDefaults.standard.set(mnemonic, forKey: "mnemonic")
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
}
