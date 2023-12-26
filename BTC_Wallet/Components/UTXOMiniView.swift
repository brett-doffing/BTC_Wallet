// UTXOMiniView.swift

import SwiftUI

struct UTXOMiniView: View {
    @State var vout: V_out
    @State var isSelected = false
    let callback: (Bool) -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill( Color.clear )
            .contentShape(RoundedRectangle(cornerRadius: 10))
            .onTapGesture(count: 1) {
                isSelected.toggle()
                callback(isSelected)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.green : Color("btcOrange"), lineWidth: 3)
                Text("\(Int(vout.value))")
            }
            .aspectRatio(1, contentMode: .fit)
    }
}

struct UTXOMiniView_Previews: PreviewProvider {
    static var previews: some View {
        UTXOMiniView(vout: PreviewMocks.tx0.v_out[0]) {_ in}
    }
}
