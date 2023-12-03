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
                let vm = MnemonicViewModel(viewModel.walletName)
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
                ForEach($viewModel.wallets, id: \.self) { wallet in
                    if let name = wallet.wrappedValue["name"] {
                        getWallet(by: name)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
    }

    private func getWallet(by name: String) -> some View {
        NavigationLink(name) {
            let vm = MnemonicViewModel(name)
            MnemonicView(viewModel: vm)
        }
    }
}
