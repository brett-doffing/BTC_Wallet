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
                            heading: "wallets",
                            callback: { viewModel.showNameAlert = true }
                        )
                    ) {
                        ForEach($viewModel.wallets, id: \.self) { wallet in
                            if let name = wallet.wrappedValue["name"] {
                                NavigationLink(name) {
                                    let vm = MnemonicViewModel(name)
                                    MnemonicView(viewModel: vm)
                                }
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
            .alert("walletName", isPresented: $viewModel.showNameAlert) {
                TextField("walletName", text: $viewModel.walletName)
                Button("ok", action: { saveName() })
                Button("cancel", role: .cancel, action: {})
            }
        }
    }

    func saveName() {
        if viewModel.walletName != "" {
            viewModel.showMnemonic = true
        }
    }
}
