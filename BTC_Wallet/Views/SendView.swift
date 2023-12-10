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
            RecipientView()
        }
        .listRowBackground(Color.clear)
    }

    private var feeView: some View {
        Section(header: SectionHeaderView(heading: "Fee")) {
            TextField("Sats", text: $viewModel.fee)
                .textFieldStyle(.roundedBorder)
        }
        .listRowBackground(Color.clear)
    }

    private var sendView: some View {
        HStack {
            Spacer()
            ButtonX(text: "SEND") {
                print("send raw tx")
            }
            .buttonStyle(PrimaryButton())
            Spacer()
        }
        .listRowBackground(Color.clear)
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView()
    }
}
