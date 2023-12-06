// TransactionListView.swift

import SwiftUI

struct TransactionListView: View {
    @State var tx: TX
    @State var txo: V_out?
    let dateFormatter = DateFormatter()

    init(for tx: TX) {
        self.tx = tx
        self.txo = getWalletTXO()
    }

    var body: some View {
        HStack {
            Text(blockTime)
            Spacer()
            Text("\(amount) Sats")
        }
        .frame(height: 30)
    }

    var blockTime: String {
        guard let _blockTime = tx.blockTime else { return "Unconfirmed" }
        if tx.confirmed {
            let dateFromServer = Date(timeIntervalSince1970: Double(_blockTime))
            dateFormatter.doesRelativeDateFormatting = true
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .short
            return dateFormatter.string(from: dateFromServer)
        }
        return "Unconfirmed"
    }

    var amount: Int {
        guard let value = txo?.value as? Int else { return 0 }
        return value
    }

    private func getWalletTXO() -> V_out? {
        for txo in tx.v_out {
            if txo.isTXO == true {
                return txo
            }
        }
        return nil
    }
}


//struct TransactionListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionListView()
//    }
//}
