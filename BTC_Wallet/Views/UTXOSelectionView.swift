// UTXOSelectionView.swift

import SwiftUI

struct UTXOSelectionView: View {
    @EnvironmentObject var store: DataStore
//    @StateObject var viewModel = UTXOsViewModel()
    @Binding var selectedUTXOs: [V_out]

    init(_ selectedUTXOs: Binding<[V_out]>) {
        self._selectedUTXOs = selectedUTXOs
    }

    private var layout = [GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        ScrollView {
            ForEach($store.wallets) { wallet in
                Section(header:
                    HStack {
                        Text(wallet.name.wrappedValue)
                            .font(.title)
                        Spacer()
                    }
                ) {
                    LazyVGrid(columns: layout, spacing: 20) {
                        getUTXOs(for: wallet.wrappedValue)
                    }
                }
            }
        }
        .padding()
    }

    private func getUTXOs(for wallet: Wallet) -> some View {
        var utxos: [V_out] = []
        for tx in wallet.transactions {
            for vout in tx.v_out {
                if vout.isTXO == true && vout.isSpent != true {
                    utxos.append(vout)
                }
            }
        }
        return ForEach(utxos, id: \.self) { utxo in
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("btcOrange"), lineWidth: 3)
                .overlay {
                    Text("\(Int(utxo.value))")
                }
                .aspectRatio(1, contentMode: .fit)
        }
    }
}

struct UTXOSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        UTXOSelectionView(.constant([]))
    }
}
