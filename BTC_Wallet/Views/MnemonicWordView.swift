// MnemonicWordView.swift

import SwiftUI

struct MnemonicWordView: View {
    let index: Int
    @Binding var word: String
    @Binding var words: [String]
    @Binding var disabled: Bool
    var saveWord: (String, Int) -> Void
    var focus: FocusState<Int?>.Binding
    var nextFocus: (Int?) -> Void

    init(
        index: Int,
        words: Binding<[String]>,
        disabled: Binding<Bool>,
        saveWord: @escaping (String, Int) -> Void,
        focus: FocusState<Int?>.Binding,
        nextFocus: @escaping (Int?) -> Void
    ) {
        self.index = index
        self._words = words
        self._word = words[index]
        self._disabled = disabled
        self.saveWord = saveWord
        self.focus = focus
        self.nextFocus = nextFocus
    }

    var body: some View {
        HStack {
            Text("\(index + 1)")
            TextField("Word #\(index + 1)", text: $word)
                .autocapitalization(.none)
                .focused(self.focus, equals: index + 1)
                .submitLabel(index + 1 <= 11 ? .next : .done)
                .onSubmit {
                    index + 1 <= 11 ? self.nextFocus(index + 1) : nil
                    saveWord(word, (index))
                }
                .disabled(disabled)
        }
    }
}
