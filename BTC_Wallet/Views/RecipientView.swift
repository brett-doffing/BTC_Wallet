// RecipientView.swift

import SwiftUI

struct RecipientView: View {
    @StateObject var viewModel = RecipientViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("Address", text: $viewModel.address)
                    .frame(width: 200)
                    .padding(.leading, 15)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                Button {
                    print("tapped")
                } label: {
                    let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 30))
                    let image = UIImage(systemName: "qrcode.viewfinder", withConfiguration: config) ?? UIImage()
                    Image(uiImage: image)
                        .padding()
                }

            }
            TextField("Satoshis", text: $viewModel.satoshis)
                .frame(width: 200)
                .padding([.bottom, .leading], 15)
                .textFieldStyle(.roundedBorder)
        }
        .background { Color.gray }
    }
}
