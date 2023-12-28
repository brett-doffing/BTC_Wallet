// RecipientView.swift

import SwiftUI

struct RecipientView: View {
    @Binding var address: String
    @Binding var satoshis: String
    @Binding var showScanner: Bool
    var focus: FocusState<Bool?>.Binding

    var body: some View {
        VStack(alignment: .leading) {
            addressView
            amountView
        }
    }

    private var addressView: some View {
        HStack(spacing: 10) {
            TextField("Address", text: $address)
                .truncationMode(.middle)
                .textFieldStyle(.roundedBorder)
                .disabled(true) // only allow paste or scan
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
                .focused(focus, equals: true)
                .submitLabel(.done)
            Text("Satoshis")
                .foregroundColor(.gray)
                .padding(.leading)
        }
    }
}

struct RecipientView_Previews: PreviewProvider {
    static var previews: some View {
        @FocusState var focusedField: Bool?
        RecipientView(
            address: .constant(""),
            satoshis: .constant(""),
            showScanner: .constant(false),
            focus: $focusedField
        )
    }
}
