// WalletsViewModel.swift

import Foundation

@MainActor class WalletsViewModel: ObservableObject {
    @Published var keychain: BTCKeychain?
    @Published var showMnemonic = false
}
