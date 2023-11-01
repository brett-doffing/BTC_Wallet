// ContentView.swift

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1

    var body: some View {
        TabView(selection: $tabSelection) {
//            WalletView(tabSelection: $tabSelection)
//                .tabItem {
//                    Image(systemName: "bitcoinsign.circle.fill")
//                    Text("Wallet")
//                }
//                .tag(1)
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(2)
            SendView()
                .tabItem {
                    Image(systemName: "arrow.up.to.line")
                    Text("Send")
                }
                .tag(3)

        }
        .accentColor(Color("btcOrange")) // Global?
    }
}
