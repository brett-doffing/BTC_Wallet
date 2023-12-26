// WalletsView.swift

import SwiftUI

struct WalletsView: View {
    @EnvironmentObject var store: DataStore
    @Binding var tabSelection: Tab
    @State var createNewWallet = false
    @State var showNameAlert = false
    @State var showDeleteAlert = false
    @State var deletionIndex: Int? = nil
    @State var walletSelected = false
    @State var walletName: String?

    var body: some View {
        NavigationStack {
            ZStack {
                walletsList
            }
            .navigationDestination(isPresented: $createNewWallet) {
                MnemonicView()
            }
            .navigationDestination(isPresented: $walletSelected) {
                WalletView()
            }
            .alert("walletName", isPresented: $showNameAlert) {
                nameAlertView
            }
            .alert("Delete Wallet?", isPresented: $showDeleteAlert) {
                deleteAlertView
            } message: {
                Text("Are you sure you want to delete this wallet?")
            }
            .onAppear {
                walletName = nil
                walletSelected = false
            }
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
                    walletRow(wallet.wrappedValue)
                }
                .onDelete(perform: mayDeleteWallet)
            }
        }
        .listStyle(.insetGrouped)
    }

    @ViewBuilder
    private var nameAlertView: some View {
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

    @ViewBuilder
    private var deleteAlertView: some View {
        Button("delete", role: .destructive, action: {
            deleteWallet()
        })
        Button("cancel", role: .cancel, action: {})
    }

    private func walletRow(_ wallet: Wallet) -> some View {
        HStack {
            Text(wallet.name)
                .font(.headline)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            store.currentWallet = wallet
            walletSelected = true
        }
    }

    private func mayDeleteWallet(at offsets: IndexSet) {
        deletionIndex = offsets.first
        showDeleteAlert = true
    }

    private func deleteWallet() {
        guard let index = deletionIndex else { return }
        let wallet = store.wallets[index]
        store.delete(wallet)
        deletionIndex = nil
    }
}
