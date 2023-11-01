// MnemonicWordView.swift

import SwiftUI

struct MnemonicWordView: View {
    @State var text = ""
    @State var id: Int
    @State var disabled: Bool
    var saveWord: (String, Int) -> Void
    var focus: FocusState<Int?>.Binding
    var nextFocus: (Int?) -> Void

    var body: some View {
        HStack {
            Text("\(id)")
            TextField("Word #\(id)", text: $text)
                .autocapitalization(.none)
                .focused(self.focus, equals: id)
                .submitLabel(id <= 11 ? .next : .done)
                .onSubmit {
                    id <= 11 ? self.nextFocus(id) : nil
                    saveWord(text, (id - 1))
                }
                .disabled(disabled)
        }
    }
}
