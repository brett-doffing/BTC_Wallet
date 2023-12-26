// UTXOSelectionView.swift

import SwiftUI

struct UTXOSelectionView: View {
    @EnvironmentObject var store: DataStore
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
        var outs: [V_out] = []
        for tx in wallet.transactions {
            for vout in tx.v_out {
                if vout.isTXO == true && vout.isSpent != true {
                    outs.append(vout)
                }
            }
        }
        return ForEach(outs, id: \.self) { vout in
            let isSelected = selectedUTXOs.contains(vout)
            UTXOMiniView(vout: vout, isSelected: isSelected) { isSelected in
                if isSelected {
                    selectedUTXOs.append(vout)
                } else {
                    selectedUTXOs.removeAll(where: { $0 == vout })
                }
            }
        }
    }
}

//struct UTXOSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        UTXOSelectionView(.constant([]))
//    }
//}
