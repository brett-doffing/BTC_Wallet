// ButtonX.swift

import SwiftUI

struct ButtonX: View {
    var text: String
    var callback: (() -> Void)

    var body: some View {
        Button(action: callback) {
            Text(text)
        }
        .frame(width: 150, height: 50)
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("btcOrange"), lineWidth: 5)
                    .allowsHitTesting(false)
        }
    }
}
