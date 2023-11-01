// SettingsViewModel.swift

import Foundation

extension SettingsView {
    @MainActor class SettingsViewModel: ObservableObject {
        @Published var promptToDelete = false

        func deleteData() {
            UserDefaults.standard.dictionaryRepresentation().keys
                .forEach(UserDefaults.standard.removeObject(forKey:))
            promptToDelete = false
        }
    }
}
