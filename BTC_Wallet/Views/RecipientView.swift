// RecipientView.swift

import SwiftUI

struct RecipientView: View {
    @State var address = ""
    @State var satoshis = ""

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("Address", text: $address)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                Button {
                    print("tapped")
                } label: {
                    Image(systemName: "doc.on.clipboard.fill")
                        .imageScale(.large)
                        .foregroundColor(Color("btcOrange"))
                }
                Button {
                    print("tapped")
                } label: {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.title)
                        .imageScale(.large)
                        .foregroundColor(Color("btcOrange"))
                }

            }
            .padding(.horizontal)
            HStack(alignment: .center) {
                TextField("Amount", text: $satoshis)
                    .textFieldStyle(.roundedBorder)
                Text("Satoshis")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
        }
    }
}
