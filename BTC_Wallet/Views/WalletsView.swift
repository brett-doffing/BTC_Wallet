// WalletsView.swift

import SwiftUI

struct WalletsView: View {
    @Binding var tabSelection: Int
    var body: some View {
        NavigationView {
            List {
                Section(header: SectionHeaderView(heading: "Wallets", callback: callback)) {
//                    NavigationLink {
//                        WalletView()
//                    } label: {
//                        Text("Wallet")
//                    }
                }
            }
        }
    }

    func callback() {
        print("callback")
    }
}
