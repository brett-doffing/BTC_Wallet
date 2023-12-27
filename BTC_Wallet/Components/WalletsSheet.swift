// WalletsSheet.swift

import SwiftUI

struct WalletsSheet: View {
    @EnvironmentObject var store: DataStore
    var callback: (Wallet) -> Void
    
    var body: some View {
        ForEach($store.wallets) { wallet in
            HStack {
                Text(wallet.wrappedValue.name)
                    .font(.headline)
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                callback(wallet.wrappedValue)
            }
        }
    }
}

struct WalletsSheet_Previews: PreviewProvider {
    static var previews: some View {
        WalletsSheet() { _ in }
    }
}
