// AnimatedArrows.swift

import SwiftUI

struct AnimatedArrows: View {
    private let arrowCount: Int
    private let direction: Direction
    private let width: CGFloat
    private let lineWidth: CGFloat
    private let timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
        .prepend(Date()) // Trigger immediately

    @State private var scale: CGFloat = 1.0
    @State private var fade: Double = 0.0

    init(
        arrowCount: Int = 3,
        direction: Direction = .right,
        width: CGFloat = 10,
        lineWidth: CGFloat = 3.5
    ) {
        self.arrowCount = arrowCount
        self.direction = direction
        self.width = width
        self.lineWidth = lineWidth
    }

    var body: some View {
        ZStack {
            HStack{
                ForEach(0..<arrowCount, id: \.self) { i in
                    ArrowShape()
                        .stroke(style: StrokeStyle(lineWidth: lineWidth,
                                                  lineCap: .round,
                                                  lineJoin: .round ))
                        .foregroundColor(Color.white)
                        .aspectRatio(0.4, contentMode: .fit)
                        .frame(maxWidth: width)
                        .opacity(fade)
                        .scaleEffect(scale)
                        .animation(
                            Animation.easeOut(duration: 0.5)
                            .delay(0.2 * Double(i)),
                            value: scale
                        )
                }
                .onReceive(timer) { _ in
                    withAnimation {
                        scale = scale > 1 ? 1 : 1.2
                        fade = fade > 0.0 ? 0.0 : 1.0
                    }
                }
            }
            .rotationEffect(.degrees(direction.rawValue))
        }
    }

    enum Direction: Double {
        case up = -90
        case down = 90
        case left = 180
        case right = 0
    }
}

struct ArrowShape : Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height/2.0))
        path.addLine(to: CGPoint(x: 0, y: rect.size.height))

        return path
    }
}

struct AnimatedArrows_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            AnimatedArrows()
        }
    }
}
