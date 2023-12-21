// SectionHeaderView.swift

import SwiftUI

struct SectionHeaderView: View {
    let heading: String
    var btnIcon = Image(systemName: "plus")
    var callback: (() -> ())? = nil

    var body: some View {
        HStack {
            Text(heading)
            Spacer()
            if let callback = callback {
                Button {
                    callback()
                } label: {
                    btnIcon
                        .foregroundColor(Color("btcOrange"))
                }
            }
        }
        .imageScale(.large)
        .font(.headline)
        .padding(.bottom, 5)
    }
}

