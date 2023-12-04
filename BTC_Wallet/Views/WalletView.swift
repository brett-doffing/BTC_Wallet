// WalletView.swift

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct WalletView: View {
    @StateObject var viewModel: WalletViewModel

    @State private var copied = false {
        didSet {
            if copied == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation { copied = false }
                }
            }
        }
    }

    let qrContext = CIContext()
    let qrFilter = CIFilter.qrCodeGenerator()

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        Image(uiImage: generateQRCode())
                            .resizable()
                            .interpolation(.none) // Do not smooth
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding()
                        if let address = viewModel.address {
                            Text("\(address) \(Image(systemName: "doc.on.doc"))")
                                .padding()
                                .onTapGesture() {
                                    UIPasteboard.general.string = address
                                    withAnimation { copied = true }
                                }
                        } else {
                            Text("").padding()
                        }
                        List {
                            Section(header: SectionHeaderView(heading: "Transactions")) {
//                                ForEach($viewModel.transactions) { $tx in
//                                    let viewModel = TransactionViewModel(model: tx)
//                                    NavigationLink {
//                                        TransactionFullView(viewModel: viewModel)
//                                    } label: {
//                                        TransactionListView(viewModel: viewModel)
//                                    }
//                                }
                            }
                        }
                        .listStyle(.insetGrouped)
                        .refreshable {
                            viewModel.refresh()
                        }
                        Spacer()
                    }
                    if viewModel.isLoading {
                        ProgressView()
                            .scaleEffect(3)
                    }
                    if copied {
                        Text("Copied to clipboard")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("btcOrange").cornerRadius(10))
                            .position(x: geometry.frame(in: .local).width/2)
                            .transition(.move(edge: .top))
                            .padding(.top)
                            .animation(Animation.easeInOut(duration: 0.5))
                    }
                }
            }
        }
//        .onAppear { viewModel.checkForWallet() }
//        .alert("Create Wallet", isPresented: $viewModel.needsWallet,
//            actions: {
//                Button("Enter Seed Words", action: { self.tabSelection = 4 })
//                Button("Randomly Generate", action: { viewModel.randomlyGenerateSeed() })
//            },
//            message: {
//                Text("How would you like to create a seed for your wallet?")
//            }
//        )
    }

    private func generateQRCode() -> UIImage {
        guard let address = viewModel.address else {
            return UIImage()
        }
        qrFilter.message = Data(address.utf8)

        if let outputImage = qrFilter.outputImage,
           let cgImg = qrContext.createCGImage(outputImage, from: outputImage.extent)
        {
            return UIImage(cgImage: cgImg)
        }

        return UIImage()
    }
}

