// SliderLock.swift

import SwiftUI

struct SliderLock: View {
    @Binding private var unlocked: Bool
    @State private var ratio: CGFloat = 0
    @State private var touchPoint: CGFloat? = nil

    private let diameter: CGFloat = 50
    private let lineWidth: CGFloat = 2
    private let title: String

    init(unlocked: Binding<Bool>, title: String) {
        _unlocked = unlocked
        self.title = title
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {

                RoundedRectangle(cornerRadius: diameter / 2)
                    .foregroundColor(Color.clear)

                RoundedRectangle(cornerRadius: diameter / 2)
                    .frame(width: diameter + (ratio * (proxy.size.width - diameter)))
                    .foregroundColor(Color("btcOrange"))

                Text(title)
                    .frame(width: proxy.size.width)
                    .font(.headline)

                Circle()
                    .foregroundColor(.white)
                    .frame(width: diameter, height: diameter)
                    .offset(x: (proxy.size.width - diameter) * ratio)
                    .gesture(DragGesture(minimumDistance: 0)
                                .onChanged({ updateStatus(value: $0, proxy: proxy) })
                                .onEnded { _ in
                                    touchPoint = nil
                                    if ratio != 1.0 {
                                        ratio = 0
                                    } else {
                                        unlocked = true
                                    }
                                }
                    )
            }
            .frame(height: diameter)
            .overlay(border)
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                                    .onChanged({ update(value: $0, proxy: proxy) }))
        }
    }

    private var border: some View {
        RoundedRectangle(cornerRadius: (diameter + lineWidth) / 2)
            .stroke(Color("btcOrange"), lineWidth: lineWidth)
            .frame(height: diameter + lineWidth)
    }


    private func updateStatus(value: DragGesture.Value, proxy: GeometryProxy) {
        guard touchPoint == nil else { return }

        let delta = value.startLocation.x - (proxy.size.width - diameter) * ratio
        touchPoint = (diameter < value.startLocation.x && 0 < delta) ? delta : value.startLocation.x
    }

    private func update(value: DragGesture.Value, proxy: GeometryProxy) {
        guard let x = touchPoint else { return }
        touchPoint = min(diameter, max(0, x))

        var point = value.location.x - x
        let delta = proxy.size.width - diameter

        // Check the boundary
        if point < 0 {
            touchPoint = value.location.x
            point = 0

        } else if delta < point {
            touchPoint = value.location.x - delta
            point = delta
        }

        self.ratio = point / delta
    }
}

struct SliderLock_Previews: PreviewProvider {
    static var previews: some View {
        SliderLock(unlocked: .constant(false), title: "Slide to Send")
    }
}
