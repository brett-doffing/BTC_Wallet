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
                            .navigationTitle("Testnet Faucet")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Text("Get Coins")
                    }
                }
                Section {
                    Button("Delete all data") {
                        viewModel.promptToDelete = true
                    }
                }
            }
        }
        .alert("Delete Data", isPresented: $viewModel.promptToDelete,
            actions: {
                Button("Delete", role: .destructive, action: {viewModel.deleteData()})
                Button("Cancel", role: .cancel, action: {})
            },
            message: {
                Text("Are you sure you want to delete all of your data?")
            }
        )
    }
}

