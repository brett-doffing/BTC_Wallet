// SendViewModel.swift

import Foundation

extension SendView {
    @MainActor class SendViewModel: ObservableObject {
        @Published var fee = ""
        @Published var address = ""
        @Published var amountToSend = ""
        @Published var canSend = false
        @Published var isShowingScanner = false
        
        var utxos: [String] = []
        var recipients: [[String]] = []
    }
}
