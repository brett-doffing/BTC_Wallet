// SectionHeaderView.swift

import SwiftUI

struct SectionHeaderView: View {
    let heading: String
    var callback: (() -> ())? = nil
    var btnIcon = Image(systemName: "plus")

    var body: some View {
        HStack {
            Text(heading)
            Spacer()
            if let callback = callback {
                Button {
                    callback()
                } label: {
                    btnIcon
                }
            }
        }
        .padding(.bottom, 5)
    }
}

