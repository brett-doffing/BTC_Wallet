// WalletsSheet.swift

import SwiftUI

struct WalletsSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: DataStore
    var callback: (Wallet) -> Void
    
    var body: some View {
        Section {
            List($store.wallets) { wallet in
                HStack {
                    Text(wallet.wrappedValue.name)
                        .font(.headline)
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    callback(wallet.wrappedValue)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        } header: {
            Text("Select a wallet to receive the change for this transaction.")
                .padding()
        }
    }
}

struct WalletsSheet_Previews: PreviewProvider {
    static var previews: some View {
        WalletsSheet() { _ in }
    }
}
