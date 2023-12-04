// WalletViewModel.swift

import Foundation

@MainActor class WalletViewModel: ObservableObject {
    @Published var keychain: BTCKeychain?
    @Published var address: String?
    @Published var isLoading = false
    @Published var transactions: [TX] = []

    let wallet: Wallet

    init(_ wallet: Wallet) {
        self.wallet = wallet
    }
}
