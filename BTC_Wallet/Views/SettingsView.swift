// SettingsView.swift

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()

    var body: some View {
        NavigationView {
            List {
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
                Section {
                    Button("deleteAllData") {
                        viewModel.promptToDelete = true
                    }
                }
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
}

