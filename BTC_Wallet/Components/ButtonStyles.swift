// ButtonStyles.swift

import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 200, height: 50)
            .cornerRadius(5)
            .background {
                RoundedRectangle(cornerRadius: 5)
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
            .cornerRadius(5)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("btcOrange"), lineWidth: 3)
//                    .allowsHitTesting(true)
            }
            .foregroundStyle(Color("btcOrange"))
            .padding()
    }
}
