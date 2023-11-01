// RecipientViewModel.swift

import Foundation

extension RecipientView {
    @MainActor class RecipientViewModel: ObservableObject {
        @Published var address = ""
        @Published var satoshis = ""
    }
}
