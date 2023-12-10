// ButtonStyles.swift

import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 200, height: 50)
            .contentShape(Rectangle())
            .background(Color("btcOrange"))
            .cornerRadius(10)
            .foregroundStyle(.white)
            .padding(10)
            .font(.headline)
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
            .padding(10)
            .font(.headline)
    }
}
