// SendView.swift

import SwiftUI

struct SendView: View {
    @StateObject var viewModel = SendViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Fee", text: $viewModel.fee)
                .padding()
                .textFieldStyle(.roundedBorder)
            List {
                Section(header: SectionHeaderView(heading: "Recipients", callback: callback)) {
                    // ForEach...
                    RecipientView()
                        .listRowInsets(EdgeInsets())
                }
            }
            Button("SEND") {
                print("send raw tx")
            }
            .padding()
            .background { Color.gray }
        }
//        .listStyle(.plain)
    }

    func callback() {
        print("callback")
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView()
    }
}
