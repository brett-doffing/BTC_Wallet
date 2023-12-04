// WalletsView.swift

import SwiftUI

struct WalletsView: View {
    @StateObject var viewModel = WalletsViewModel()
    @Binding var tabSelection: Tab

    var body: some View {
        NavigationStack {
            ZStack {
                walletsList
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
                let vm = MnemonicViewModel(wallets: viewModel.wallets, currentWallet: viewModel.walletName)
                MnemonicView(viewModel: vm)
            }
            .alert("walletName", isPresented: $viewModel.showNameAlert) {
                TextField("walletName", text: $viewModel.walletName)
                Button("ok", action: { viewModel.saveName() })
                Button("cancel", role: .cancel, action: {})
            }
        }
    }

    private var walletsList: some View {
        List {
            Section(
                header: SectionHeaderView(
                    heading: "wallets",
                    callback: { viewModel.showNameAlert = true }
                )
            ) {
                ForEach($viewModel.wallets) { wallet in
                    getWallet(wallet.wrappedValue)
                }
            }
        }
        .listStyle(.insetGrouped)
    }

    private func getWallet(_ wallet: Wallet) -> some View {
        NavigationLink(wallet.name) {
            let vm = MnemonicViewModel(wallet)
            MnemonicView(viewModel: vm)
        }
    }
}
