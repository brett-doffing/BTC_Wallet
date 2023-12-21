// SendView.swift

import CodeScanner
import SwiftUI

struct SendView: View {
    @StateObject var viewModel = SendViewModel()
    
    var body: some View {
        VStack {
            List {
                recipientView
                feeView
                selectionView
                sendView
            }
        }
        .navigationDestination(isPresented: $viewModel.selectUTXOs) {
            UTXOSelectionView()
        }
        .sheet(isPresented: $viewModel.isShowingScanner) {
            CodeScannerView(
                codeTypes: [.qr],
                simulatedData: "bitcoin:n3qSUp3c5x6tKD3qYmwe28WnEHBTvNyNic",
                completion: { viewModel.handleScan(result: $0) }
            )
        }
    }

    private var recipientView: some View {
        Section(header: SectionHeaderView(heading: "Recipient")) {
            RecipientView(
                address: $viewModel.address,
                satoshis: $viewModel.amountToSend,
                showScanner: $viewModel.isShowingScanner
            )
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

    private var selectionView: some View {
        Section(header: SectionHeaderView(heading: "Selected UTXO's",
                                          callback: { viewModel.selectUTXOs = true })
        ) {
            ForEach($viewModel.selectedUTXOs, id: \.self) { _ in

            }
        }
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
