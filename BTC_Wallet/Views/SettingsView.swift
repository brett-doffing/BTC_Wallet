// SettingsView.swift

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()

    var body: some View {
        NavigationView {
            List {
                getCoinsItem
                deleteDataItem
            }
        }
        .alert("deleteData", isPresented: $viewModel.promptToDelete,
            actions: {
                Button("delete", role: .destructive, action: {viewModel.deleteData()})
                Button("cancel", role: .cancel, action: {})
            },
            message: {
                Text("questionDeleteData")
            }
        )
    }

    private var getCoinsItem: some View {
        Section {
            NavigationLink {
                WebView(url: URL(string: "https://coinfaucet.eu/en/btc-testnet/")!)
                    .ignoresSafeArea()
                    .navigationTitle("faucet")
                    .navigationBarTitleDisplayMode(.inline)
            } label: {
                Text("getCoins")
            }
        }
    }

    private var deleteDataItem: some View {
        Section {
            Button("deleteAllData") {
                viewModel.promptToDelete = true
            }
        }
    }
}

