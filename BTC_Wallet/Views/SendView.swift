// SendView.swift

import SwiftUI

struct SendView: View {
    @StateObject var viewModel = SendViewModel()
    
    var body: some View {
        VStack {
            List {
                recipientView
                feeView
                sendView
            }
        }
    }

    private var recipientView: some View {
        Section(header: SectionHeaderView(heading: "Recipient")) {
            RecipientView(address: $viewModel.address, satoshis: $viewModel.amountToSend)
        }
        .listRowBackground(Color.clear)
    }

    private var feeView: some View {
        Section(header: SectionHeaderView(heading: "Fee")) {
            HStack(alignment: .center) {
                TextField("Amount", text: $viewModel.fee)
                    .frame(maxWidth: 200)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                Text("Satoshis")
                    .foregroundColor(.gray)
            }
        }
        .listRowBackground(Color.clear)
    }

    private var sendView: some View {
        SliderLock(unlocked: $viewModel.canSend, title: "Slide to Send")
            .frame(height: 50)
        .listRowBackground(Color.clear)
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView()
    }
}
