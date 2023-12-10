// SendView.swift

import SwiftUI

struct SendView: View {
    @StateObject var viewModel = SendViewModel()
    
    var body: some View {
        VStack {
            List {
                Section(header: SectionHeaderView(heading: "Recipient")) {
                    RecipientView()
                        .listRowInsets(EdgeInsets())
                }
                .listRowBackground(Color.clear)
                Section(header: SectionHeaderView(heading: "Fee")) {
                    TextField("Sats", text: $viewModel.fee)
                        .textFieldStyle(.roundedBorder)
                }
                .listRowBackground(Color.clear)
                HStack {
                    Spacer()
                    ButtonX(text: "SEND") {
                        print("send raw tx")
                    }
                    .buttonStyle(PrimaryButton())
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }
        }
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView()
    }
}
