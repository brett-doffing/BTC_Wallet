// ButtonX.swift

import SwiftUI

struct ButtonX: View {
    var text: LocalizedStringKey
    var callback: (() -> Void)

    var body: some View {
        Button(text, action: callback)
    }
}
