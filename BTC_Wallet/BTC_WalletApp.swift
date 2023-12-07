// BTC_WalletApp.swift

import SwiftUI

@main
struct BTC_WalletApp: App {

    init() {
        // Initialize context for performance
        _ = BTCCurve.shared
    }

    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.font, Font.custom("Futura", size: 14))
        }
    }
}
