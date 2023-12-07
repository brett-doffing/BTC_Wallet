// AppView.swift

import SwiftUI

enum Tab {
    case wallets
    case send
    case settings
}

struct AppView: View {
    @StateObject var wallets = Wallets()
    @State private var tabSelection = Tab.wallets

    var body: some View {
        TabView(selection: $tabSelection) {
            WalletsView(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "bitcoinsign.circle.fill")
                    Text("Wallets")
                }
                .tag(Tab.wallets)
            SendView()
                .tabItem {
                    Image(systemName: "arrow.up.to.line")
                    Text("Send")
                }
                .tag(Tab.send)
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(Tab.settings)

        }
        .accentColor(Color("btcOrange"))
        .environmentObject(wallets)
    }
}
