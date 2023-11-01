// WalletsView.swift

import SwiftUI

struct WalletsView: View {
    @StateObject var viewModel = WalletsViewModel()
    @Binding var tabSelection: Tab

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    Section(header: SectionHeaderView(heading: "Wallets", callback: callback)) {
//                        NavigationLink {
//                            WalletView()
//                        } label: {
//                            Text("Wallet")
//                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .onAppear { viewModel.checkForMnemonic() }
        .alert("Create Mnemonic", isPresented: $viewModel.needsMnemonic,
            actions: {
            Button("Enter Seed Words", action: { self.tabSelection = .settings })
                Button("Randomly Generate", action: { viewModel.randomlyGenerateSeed() })
            },
            message: {
                Text("How would you like to create a seed for your wallet?")
            }
        )
    }

    func callback() {
        print("callback")
    }
}
