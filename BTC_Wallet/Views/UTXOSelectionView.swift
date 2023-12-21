// UTXOSelectionView.swift

import SwiftUI

struct UTXOSelectionView: View {
    @EnvironmentObject var store: DataStore
    @StateObject var viewModel = UTXOsViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct UTXOSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        UTXOSelectionView()
    }
}
