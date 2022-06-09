//
//  RotateImage.swift
//  Changes
//
//  Created by aiqin139 on 2021/2/17.
//

import SwiftUI
import CoreLocation

struct HexagramShape: Shape {
    var scale1: CGFloat = 0.2929
    var scale2: CGFloat = 0.7071
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * scale1, y: 0))
        path.addLine(to: CGPoint(x: rect.width * scale2, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height * scale1))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height * scale2))
        path.addLine(to: CGPoint(x: rect.width * scale2, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width * scale1, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height * scale2))
        path.addLine(to: CGPoint(x: 0, y: rect.height * scale1))
        path.closeSubpath()
        return path
    }
}

struct RotateEightTrigrams: View {
    var lineWidth: CGFloat = 0
    var lineColor: Color = Color.black
    var locationManager = CLLocationManager()
    @ObservedObject var location: LocationProvider = LocationProvider()
    @State var angle: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            VStack {
                EightTrigramsSymbol()
                    .overlay(HexagramShape().stroke(lineColor, lineWidth: lineWidth))
                    .animation(.linear)
                    .onReceive(self.location.heading) { heading in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            self.angle += self.angleDiff(to: heading)
                        }
                    }
                    .modifier(RotationEffect(
                                angle: self.angle,
                                x: geometry.size.width / 2,
                                y: geometry.size.height / 2
                            )
                    )
            }
        }
    }
    
    //If you ever need the current value of angle clamped to 0..<360,
    //use clampAngle(self.angle)
    func clampAngle(_ angle: CGFloat) -> CGFloat {
        var angle = angle
        while angle < 0 {
            angle += 360
        }
        return angle.truncatingRemainder(dividingBy: 360)
    }

    //Calculates the difference between heading and angle
    func angleDiff(to heading: CGFloat) -> CGFloat {
        return (clampAngle(heading - self.angle) + 180).truncatingRemainder(dividingBy: 360) - 180
    }
}


struct RotationEffect: GeometryEffect {
    var angle: CGFloat
    var x: CGFloat
    var y: CGFloat

    var animatableData: CGFloat {
        get { angle }
        set { angle = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(
          CGAffineTransform(translationX: -x, y: -y)
            .concatenating(CGAffineTransform(rotationAngle: -CGFloat(angle.degreesToRadians)))
            .concatenating(CGAffineTransform(translationX: x, y: y))
        )
    }
}


public extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}


struct RotateImage_Previews: PreviewProvider {
    static var previews: some View {
        RotateEightTrigrams()
            .frame(width: 350, height: 350)
            .shadow(radius: 10)
    }
}
