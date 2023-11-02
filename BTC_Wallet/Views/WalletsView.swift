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
                Button("Create Seed Words", action: { self.tabSelection = .settings })
            },
            message: {
                Text("It looks like you need a seed for you wallets.")
            }
        )
    }

    func callback() {
        print("callback")
    }
}
