// SendTransactionView.swift

import SwiftUI

struct SendTransactionView: View {
    @State var canSend = false
    @State var transaction: Transaction?
    let service = BlockstreamService()

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
            if canSend, let rawTX = transaction?.rawTX {
                print("HEX TX: \(rawTX.hexDescription())")
//                Task {
//                    await send(rawTX)
//                }
            }
            canSend = false
        }
    }

    private func send(_ rawTX: Data) async {
        do {
            let txID = try await service.post(rawTX: rawTX)
            print(txID)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct SendSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SendTransactionView()
    }
}
