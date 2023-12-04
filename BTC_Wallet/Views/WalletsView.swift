// WalletsView.swift

import SwiftUI

struct WalletsView: View {
    @EnvironmentObject var wallets: Wallets
    @StateObject var viewModel = WalletsViewModel()
    @Binding var tabSelection: Tab

    var body: some View {
        NavigationStack {
            ZStack {
                walletsList
            }
            .navigationDestination(isPresented: $viewModel.showMnemonic) {
                let vm = MnemonicViewModel(currentWallet: viewModel.walletName)
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
                ForEach($wallets.wallets) { wallet in
                    getWallet(wallet.wrappedValue)
                }
            }
        }
        .listStyle(.insetGrouped)
    }

    private func getWallet(_ wallet: Wallet) -> some View {
        NavigationLink(wallet.name) {
            let vm = WalletViewModel(wallet)
            WalletView(viewModel: vm)
        }
    }
}
