// RecipientView.swift

import SwiftUI

struct RecipientView: View {
    @Binding var address: String
    @Binding var satoshis: String

    var body: some View {
        VStack(alignment: .leading) {
            addressView
            amountView
        }
    }

    private var addressView: some View {
        HStack(spacing: 10) {
            TextField("Address", text: $address)
                .textFieldStyle(.roundedBorder)
            Spacer()
            Button {
                print("tapped")
            } label: {
                Image(systemName: "doc.on.clipboard.fill")
                    .imageScale(.medium)
                    .foregroundColor(Color("btcOrange"))
            }
            Button {
                print("tapped")
            } label: {
                Image(systemName: "qrcode.viewfinder")
                    .font(.title)
                    .imageScale(.medium)
                    .foregroundColor(Color("btcOrange"))
            }

        }
    }

    private var amountView: some View {
        HStack(alignment: .center) {
            TextField("Amount", text: $satoshis)
                .frame(maxWidth: 200)
                .textFieldStyle(.roundedBorder)
            Spacer()
            Text("Satoshis")
                .foregroundColor(.gray)
        }
    }
}

struct RecipientView_Previews: PreviewProvider {
    static var previews: some View {
        RecipientView(address: .constant(""), satoshis: .constant(""))
    }
}
