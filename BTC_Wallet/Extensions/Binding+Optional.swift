// Binding+Optional.swift

import SwiftUI

extension Binding {
    static func ??(lhs: Binding<Value?>, rhs: Value) -> Self {
        Binding(
            get: { lhs.wrappedValue ?? rhs },
            set: { lhs.wrappedValue = $0 }
        )
    }
}
