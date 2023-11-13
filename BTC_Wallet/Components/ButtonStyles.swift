// ButtonStyles.swift

import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 200, height: 50)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("btcOrange"))
            }
            .foregroundStyle(.white)
            .padding()
    }
}

struct SecondaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 200, height: 50)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("btcOrange"), lineWidth: 3)
            }
            .foregroundStyle(Color("btcOrange"))
            .padding()
    }
}
