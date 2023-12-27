// SendTransactionView.swift

import SwiftUI

struct SendTransactionView: View {
    @State var canSend = false
    @State var transaction: Transaction?

    var body: some View {
        VStack {
            if let tx = transaction?.rawTX?.hexDescription() {
                Text(tx)
                    .padding()
            }
            SliderLock(unlocked: $canSend, title: "Slide to Send")
                .frame(height: 50)
                .padding()
        }
    }
}

struct SendSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SendTransactionView()
    }
}
