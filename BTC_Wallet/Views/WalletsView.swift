// WalletsView.swift

import SwiftUI

struct WalletsView: View {
    @StateObject var viewModel = WalletsViewModel()
    @Binding var tabSelection: Tab

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section(
                        header: SectionHeaderView(
                            heading: "Wallets",
                            callback: { viewModel.showNameAlert = true }
                        )
                    ) {
                        ForEach($viewModel.wallets, id: \.self) { wallet in
                            if let name = wallet.wrappedValue["name"] {
                                Text(name)
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .onChange(of: tabSelection) { selection in
                if selection == .wallets {
                    viewModel.getWallets()
                }
            }
            .onAppear {
                viewModel.getWallets()
            }
            .navigationDestination(isPresented: $viewModel.showMnemonic) {
                let vm = MnemonicViewModel(viewModel.walletName)
                MnemonicView(viewModel: vm)
            }
            .alert("Wallet Name", isPresented: $viewModel.showNameAlert) {
                TextField("WalletName", text: $viewModel.walletName)
                Button("OK", action: { saveName() })
            }
        }
    }

    func saveName() {
        viewModel.showMnemonic = true
    }
}
