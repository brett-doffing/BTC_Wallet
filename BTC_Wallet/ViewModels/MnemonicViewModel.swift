// MnemonicViewModel.swift

import Foundation

extension MnemonicView {
    @MainActor class MnemonicViewModel: ObservableObject {
        @Published var words: [String] = []
        @Published var hasMnemonic = false
//        @Published var isValidated = false

        init() {
            checkForMnemonic()
        }

        func checkForMnemonic() {
            if let mnemonic = UserDefaults.standard.object(forKey: "mnemonic") as? String {
                words = mnemonic.components(separatedBy: " ")
                hasMnemonic = true
//                isValidated = true
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
    }
}
