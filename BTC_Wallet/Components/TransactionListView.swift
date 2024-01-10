// TransactionListView.swift

import SwiftUI

struct TransactionListView: View {
    @State var tx: TX
    var txo: V_out?
    let dateFormatter = DateFormatter()
    var arrowImageName: String {
        if txo?.isSpent == true { return "arrow.up.to.line" }
        return "arrow.down.to.line"
    }

    init(for tx: TX) {
        self.tx = tx
        self.txo = getWalletTXO()
    }

    var body: some View {
        HStack {
            Image(systemName: arrowImageName)
                .imageScale(.large)
            HStack {
                VStack(alignment: .leading) {
                    Text(txo?.isSpent == true ? "Sent:" : "Received:")
                    Text(blockTime)
                        .font(.callout)
                        .foregroundColor(blockTime == "Unconfirmed" ? .red : .gray)
                }
                Spacer()
                Text("\(Int(txo?.value ?? 0)) Sats")
                    .minimumScaleFactor(0.1)
            }
        }
        .font(.headline)
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

    private func getWalletTXO() -> V_out? {
        for txo in tx.v_out {
            if txo.isTXO == true {
                return txo
            }
        }
        return nil
    }
}


struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionListView(for: PreviewMocks.tx1)
            TransactionListView(for: PreviewMocks.tx2)
        }
    }
}
