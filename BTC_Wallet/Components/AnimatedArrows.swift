// AnimatedArrows.swift

import SwiftUI

struct AnimatedArrows: View {
    private let arrowCount: Int
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    private let direction: Direction
    private let size: CGFloat

    @State var scale: CGFloat = 1.0
    @State var fade: Double = 0.0

    init(
        arrowCount: Int = 3,
        direction: Direction = .right,
        size: CGFloat = 10
    ) {
        self.arrowCount = arrowCount
        self.direction = direction
        self.size = size
    }

    var body: some View {
        ZStack {
            HStack{
                ForEach(0..<arrowCount, id: \.self) { i in
                    ArrowShape()
                        .stroke(style: StrokeStyle(lineWidth: size / 3,
                                                  lineCap: .round,
                                                  lineJoin: .round ))
                        .foregroundColor(Color.white)
                        .aspectRatio(0.4, contentMode: .fit)
                        .frame(maxWidth: size)
                        .opacity(self.fade)
                        .scaleEffect(self.scale)
                        .animation(
                            Animation.easeOut(duration: 0.5)
                            .repeatCount(1, autoreverses: true)
                            .delay(0.2 * Double(i))
                        )
                }.onReceive(self.timer) { _ in
                     self.scale = self.scale > 1 ? 1 : 1.2
                     self.fade = self.fade > 0.0 ? 0.0 : 1.0
                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.scale = 1
                                self.fade = 0.0
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
