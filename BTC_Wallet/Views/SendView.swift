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
                sendView
            }
        }
        .sheet(isPresented: $viewModel.isShowingScanner) {
            CodeScannerView(
                codeTypes: [.qr],
                simulatedData: "bitcoin:n3qSUp3c5x6tKD3qYmwe28WnEHBTvNyNic",
                completion: handleScan
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

    private var sendView: some View {
        SliderLock(unlocked: $viewModel.canSend, title: "Slide to Send")
            .frame(height: 50)
        .listRowBackground(Color.clear)
    }

    private func handleScan(result: Result<ScanResult, ScanError>) {
        viewModel.isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: ":")
            guard details.count == 2 else { return }

            viewModel.address = details[1]
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView()
    }
}
