// SendView.swift

import CodeScanner
import SwiftUI

struct SendView: View {
    @StateObject var viewModel = SendViewModel()
    @FocusState private var focusedField: Bool?
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    recipientView
                    feeView
                    selectionView
                    receiveChangeView
                    sendView
                }
            }
            .disabled(viewModel.isLoading)
            .toolbar { doneBar }
            .overlay {
                if viewModel.isLoading { ProgressView("Processing").scaleEffect(1.5) }
            }
            .navigationDestination(isPresented: $viewModel.selectUTXOs) {
                UTXOSelectionView($viewModel.selectedUTXOs)
            }
            .navigationDestination(isPresented: $viewModel.canSend) {
                SendTransactionView(transaction: viewModel.transaction)
            }
            .sheet(isPresented: $viewModel.isShowingScanner) {
                codeScanner
            }
            .sheet(isPresented: $viewModel.showWalletSheet) {
                WalletsSheet { wallet in
                    viewModel.changeWallet = wallet
                }
            }
            .alert("Invalid Transaction", isPresented: $viewModel.showAlert) {
                Button("ok", role: .cancel, action: {
                    viewModel.alertMessage = ""
                })
            } message: {
                Text(viewModel.alertMessage)
            }

        }
        .onAppear {
            if viewModel.changeWallet == nil {
                viewModel.changeWallet = viewModel.store.wallets.first
            }
        }
    }

    private var recipientView: some View {
        Section(header: SectionHeaderView(heading: "Recipient")) {
            RecipientView(
                address: $viewModel.address,
                satoshis: $viewModel.amountToSend,
                showScanner: $viewModel.isShowingScanner,
                focus: $focusedField
            )
        }
        .listRowBackground(Color.clear)
    }

    private var feeView: some View {
        Section(header: SectionHeaderView(heading: "Fee")) {
            HStack(alignment: .center) {
                TextField("Amount", text: $viewModel.fee)
                    .focused($focusedField, equals: true)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                Spacer()
                Text("Satoshis")
                    .foregroundColor(.gray)
                    .padding(.leading)
            }
        }
        .listRowBackground(Color.clear)
    }

    private var selectionView: some View {
        Section(header: SectionHeaderView(
            heading: "Selected Outputs",
            callback: { viewModel.selectUTXOs = true })
        ) {
            ForEach($viewModel.selectedUTXOs, id: \.self) { $out in
                selectedUTXO($out.wrappedValue)
            }
        }
    }

    private var receiveChangeView: some View {
        Section(header: SectionHeaderView(
            heading: "wallet to receive change",
            btnIcon: Image(systemName: "pencil"),
            callback: { viewModel.showWalletSheet = true })
        ) {
            if let changeWallet = $viewModel.changeWallet.wrappedValue {
                Text(changeWallet.name).font(.headline)
            } else {
                EmptyView()
            }
        }
    }

    private var sendView: some View {
        HStack {
            ButtonX(text: "Next") {
                viewModel.validateTransaction()
            }
            .buttonStyle(PrimaryButton())
        }
        .listRowBackground(Color.clear)
    }

    private var codeScanner: some View {
        CodeScannerView(
            codeTypes: [.qr],
            simulatedData: "bitcoin:n3qSUp3c5x6tKD3qYmwe28WnEHBTvNyNic",
            completion: { viewModel.handleScan(result: $0) }
        )
    }

    private var doneBar: ToolbarItemGroup<some View> {
        ToolbarItemGroup(placement: .keyboard) {
            Spacer()
            Button("Done") {
                focusedField = nil
            }
        }
    }

    private func selectedUTXO(_ vout: V_out) -> some View {
        HStack {
            Text("\(Int(vout.value))")
            Text("Satoshis")
        }
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView()
    }
}
