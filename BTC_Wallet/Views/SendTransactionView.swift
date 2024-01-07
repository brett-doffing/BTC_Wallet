// SendTransactionView.swift

import SwiftUI

struct SendTransactionView: View {
    @State var canSend = false
    @State var transaction: Transaction?

    var body: some View {
        VStack {
            if let transaction {
                List {
                    Section("Send:") {
                        Text("\(transaction.receiverAmounts[0]) Satoshis")
                    }
                    Section("To:") {
                        Text(transaction.receivingAddresses[0])
                    }
                    Section("Fee:") {
                        Text("\(transaction.fee) Satoshis")
                        Text("\(transaction.feePerVByte) sats/vByte")
                    }
                    Section("Total:") {
                        Text("\(transaction.fee + Int(transaction.receiverAmounts[0])) Satoshis")
                    }
                }
            }
            Spacer()
            SliderLock(unlocked: $canSend, title: "Slide to Send")
                .frame(height: 50)
                .padding()
        }
        .onChange(of: canSend) { newValue in
            if canSend, let tx = transaction?.rawTX {
                print(tx)
                print("HEX Count: \(tx.hexDescription().count)")
                print("BYTES Count: \(tx.bytes.count)")
                canSend = false
            }
        }
    }
}

struct SendSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SendTransactionView()
    }
}
