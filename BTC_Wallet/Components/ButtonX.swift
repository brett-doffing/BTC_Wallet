// ButtonX.swift

import SwiftUI

struct ButtonX: View {
    var text: String
    var callback: (() -> Void)

    var body: some View {
        Button(text, action: callback)
    }
}
