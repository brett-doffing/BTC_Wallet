// MnemonicWordView.swift

import SwiftUI

struct MnemonicWordView: View {
    @Binding var word: String

    let index: Int
    var saveWord: (String, Int) -> Void
    var focus: FocusState<Int?>.Binding
    var nextFocus: (Int?) -> Void

    init(
        index: Int,
        word: Binding<String>,
        saveWord: @escaping (String, Int) -> Void,
        focus: FocusState<Int?>.Binding,
        nextFocus: @escaping (Int?) -> Void
    ) {
        self.index = index
        self._word = word
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
        }
        .padding(5)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(lineWidth: 1)
        }
    }
}
