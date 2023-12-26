// RecipientView.swift

import SwiftUI

struct RecipientView: View {
    @Binding var address: String
    @Binding var satoshis: String
    @Binding var showScanner: Bool

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
                address = UIPasteboard.general.string ?? ""
            } label: {
                Image(systemName: "doc.on.clipboard.fill")
                    .imageScale(.medium)
                    .foregroundColor(Color("btcOrange"))
            }
            Button {
                showScanner = true
            } label: {
                Image(systemName: "qrcode.viewfinder")
                    .font(.title)
                    .imageScale(.medium)
                    .foregroundColor(Color("btcOrange"))
            }
        }
        .buttonStyle(BorderlessButtonStyle()) // prevents both button actions occuring simultaneously
    }

    private var amountView: some View {
        HStack(alignment: .center) {
            TextField("Amount", text: $satoshis)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            Text("Satoshis")
                .foregroundColor(.gray)
        }
    }
}

struct RecipientView_Previews: PreviewProvider {
    static var previews: some View {
        RecipientView(
            address: .constant(""),
            satoshis: .constant(""),
            showScanner: .constant(false)
        )
    }
}
