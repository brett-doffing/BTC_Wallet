// WalletView.swift

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct WalletView: View {
    @StateObject var viewModel = WalletViewModel()

    let qrContext = CIContext()
    let qrFilter = CIFilter.qrCodeGenerator()

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                if !viewModel.isLoading { content }
                if viewModel.copiedAddress { showCopiedText(with: geometry) }
            }
        }
        .overlay {
            if viewModel.isLoading { ProgressView("Loading").scaleEffect(1.5) }
        }
        .onAppear {
            Task { await viewModel.fetchTransactions() }
        }
    }

    private var content: some View {
        VStack {
            addressSection
            transactionsList
            Spacer()
        }
    }

    private var addressSection: some View {
        VStack {
            Image(uiImage: generateQRCode())
                .resizable()
                .interpolation(.none) // Do not smooth
                .scaledToFit()
                .frame(width: 200, height: 200)
                .shadow(radius: 10)
                .padding()
            if let address = viewModel.wallet.receiveAddress {
                HStack {
                    Text("\(address)")
                        .scaledToFill()
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                    Image(systemName: "doc.on.doc")
                }
                .fontWeight(.bold)
                .foregroundColor(Color("btcOrange"))
                .padding()
                .onTapGesture() {
                    UIPasteboard.general.string = address
                    withAnimation { viewModel.copiedAddress = true }
                    withAnimation(.easeInOut.delay(1.5)) { viewModel.copiedAddress = false }
                }
            }
        }
    }

    private var transactionsList: some View {
        List {
            Section(header: SectionHeaderView(heading: "Transactions")) {
                ForEach($viewModel.wallet.transactions) { $tx in
                    TransactionListView(for: $tx.wrappedValue)
                }
            }
        }
        .listStyle(.insetGrouped)
        .refreshable {
            Task { await viewModel.refresh() }
        }
    }

    private func showCopiedText(with geometry: GeometryProxy) -> some View {
        Text("Copied to clipboard")
            .padding()
            .foregroundColor(.white)
            .background(Color("btcOrange").cornerRadius(5))
            .position(x: geometry.frame(in: .local).width/2)
            .transition(.move(edge: .top))
            .zIndex(1)
            .padding(.top)
    }

    private func generateQRCode() -> UIImage {
        guard let address = viewModel.wallet.receiveAddress else {
            return UIImage()
        }
        qrFilter.message = Data("bitcoin:\(address)".utf8)

        if let outputImage = qrFilter.outputImage,
           let cgImg = qrContext.createCGImage(outputImage, from: outputImage.extent)
        {
            return UIImage(cgImage: cgImg)
        }

        return UIImage()
    }
}

