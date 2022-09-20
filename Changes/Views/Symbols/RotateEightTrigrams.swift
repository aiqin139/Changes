//
//  RotateEightTrigrams.swift
//  Changes
//
//  Created by aiqin139 on 2021/2/17.
//

import SwiftUI
import CoreMotion
import Combine

struct RotateEightTrigrams: View {
    var lineWidth: CGFloat = 0
    var lineColor: Color = Color.black
    @ObservedObject var motion: MotionManger = MotionManger()
    @State var angle: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                EightTrigramsSymbol()
                    .overlay(HexagramShape().stroke(lineColor, lineWidth: lineWidth))
                    .animation(.linear)
                    .onReceive(self.motion.yaw) { yaw in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            self.angle += self.angleDiff(to: yaw)
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
            .concatenating(CGAffineTransform(rotationAngle: CGFloat(angle * .pi / 180)))
            .concatenating(CGAffineTransform(translationX: x, y: y))
        )
    }
}


class MotionManger: ObservableObject {
    private var manager: CMMotionManager
    
    public let yaw = PassthroughSubject<CGFloat, Never>()
    
    @Published var currentYaw: CGFloat {
        willSet {
            yaw.send(newValue)
        }
    }
    
    init() {
        currentYaw = 0
        self.manager = CMMotionManager()
        self.manager.deviceMotionUpdateInterval = 1 / 20
        self.manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
            guard error == nil else {
                print(error!)
                return
            }
            
            if let motionData = motionData {
                self.currentYaw = CGFloat(motionData.attitude.yaw * 180 / .pi)
            }
        }
    }
}


struct RotateImage_Previews: PreviewProvider {
    static var previews: some View {
        RotateEightTrigrams(lineWidth: 2.0)
            .frame(width: 350, height: 350)
    }
}
