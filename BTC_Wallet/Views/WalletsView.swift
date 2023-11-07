// WalletsView.swift

import SwiftUI

struct WalletsView: View {
    @StateObject var viewModel = WalletsViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section(
                        header: SectionHeaderView(
                            heading: "Wallets",
                            callback: showMnemonic
                        )
                    ) {

                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationDestination(isPresented: $viewModel.showMnemonic) {
                MnemonicView()
            }
        }
    }

    func showMnemonic() {
        viewModel.showMnemonic = true
    }
}
