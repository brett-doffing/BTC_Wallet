// WalletsView.swift

import SwiftUI

struct WalletsView: View {
    @EnvironmentObject var store: DataStore
    @Binding var tabSelection: Tab
    @State var createNewWallet = false
    @State var showNameAlert = false
    @State var walletName: String?

    var body: some View {
        NavigationStack {
            ZStack {
                walletsList
            }
            .navigationDestination(isPresented: $createNewWallet) {
                MnemonicView()
            }
            .alert("walletName", isPresented: $showNameAlert) {
                TextField("walletName", text: $walletName ?? "")
                    .font(.headline)
                Button("ok", action: {
                    if let walletName {
                        store.currentWallet = Wallet(name: walletName)
                        createNewWallet = true
                    }
                })
                Button("cancel", role: .cancel, action: {})
            }
            .onAppear { walletName = nil }
        }
    }

    private var walletsList: some View {
        List {
            Section(
                header: SectionHeaderView(
                    heading: "wallets",
                    callback: { showNameAlert = true }
                )
            ) {
                ForEach($store.wallets) { wallet in
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
        .font(.headline)
    }
}
