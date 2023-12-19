// SendViewModel.swift

import Foundation

extension SendView {
    @MainActor class SendViewModel: ObservableObject {
        @Published var fee = ""
        @Published var address = ""
        @Published var amountToSend = ""
        @Published var canSend = false
        
        var utxos: [String] = []
        var recipients: [[String]] = []
    }
}
