// SendViewModel.swift

import Foundation

extension SendView {
    @MainActor class SendViewModel: ObservableObject {
        @Published var fee = ""
        var utxos: [String] = []
        var recipients: [[String]] = []
    }
}
