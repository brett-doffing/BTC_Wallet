// UTXOsView.swift

import SwiftUI

struct UTXOsView: View {
    @EnvironmentObject var wallets: Wallets
    @StateObject var viewModel = UTXOsViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct UTXOsView_Previews: PreviewProvider {
    static var previews: some View {
        UTXOsView()
    }
}
