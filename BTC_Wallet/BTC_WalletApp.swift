// BTC_WalletApp.swift

import SwiftUI

@main
struct BTC_WalletApp: App {
    @State var shouldAuthenticate = true

    init() {
        // Initialize context for performance
        _ = BTCCurve.shared

        #if DEBUG
        shouldAuthenticate = false
        #endif
    }

    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.font, Font.custom("Futura", size: 14))
                .fullScreenCover(isPresented: $shouldAuthenticate) {
                    AuthView()
                }
                .onReceive(NotificationCenter.default.publisher(
                        for: UIApplication.willEnterForegroundNotification)
                ) { _ in
                    shouldAuthenticate = true
                }
        }
    }
}
