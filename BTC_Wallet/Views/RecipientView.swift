// RecipientView.swift

import SwiftUI

struct RecipientView: View {
    @State var address = ""
    @State var satoshis = ""

    var body: some View {
        VStack(alignment: .leading) {
            addressView
            amountView
        }
    }

    private var addressView: some View {
        HStack(spacing: 10) {
            TextField("Address", text: $address)
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
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
    }

    private var amountView: some View {
        HStack(alignment: .center) {
            TextField("Amount", text: $satoshis)
            Text("Satoshis")
                .foregroundColor(.gray)
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
    }
}

struct RecipientView_Previews: PreviewProvider {
    static var previews: some View {
        RecipientView()
    }
}
