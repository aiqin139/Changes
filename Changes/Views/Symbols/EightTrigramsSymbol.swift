//
//  EightTrigramsSymbol.swift
//  Changes
//
//  Created by aiqin139 on 2022/6/9.
//

import SwiftUI

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

struct TaiChiSymbol: View {
    var body: some View {
        GeometryReader { geometry in
            let midX = geometry.size.width * 0.5
            let minY = geometry.size.height * 0.5
            let bigRadius = geometry.size.width * 0.5
            let mediumRadius = bigRadius * 0.5
            let smallRadius = bigRadius * 0.15
            
            Path { path in
                //big circle
                path.move(to: CGPoint(x: midX, y: minY + bigRadius))
                path.addArc(center: CGPoint(x: midX, y: minY), radius: bigRadius, startAngle: .degrees(90), endAngle: .degrees(630), clockwise: false)

                //upper half circle
                path.addArc(center: CGPoint(x: midX, y: minY - mediumRadius), radius: mediumRadius, startAngle: .degrees(270), endAngle: .degrees(90), clockwise: false)

                //bottom half circle
                path.addArc(center: CGPoint(x: midX, y: minY + mediumRadius), radius: mediumRadius, startAngle: .degrees(270), endAngle: .degrees(90), clockwise: true)
                
                //upper circle
                path.move(to: CGPoint(x: midX + smallRadius, y: minY - mediumRadius))
                path.addArc(center: CGPoint(x: midX, y: minY - mediumRadius), radius: smallRadius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
                
                //bottom circle
                path.move(to: CGPoint(x: midX + smallRadius, y: minY + mediumRadius))
                path.addArc(center: CGPoint(x: midX, y: minY + mediumRadius), radius: smallRadius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
            }
            .fill(style: FillStyle.init(eoFill: true, antialiased: true))
            .background(Circle().stroke())
        }
    }
}

struct EightTrigramsSymbol: View {
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                let midX = geometry.frame(in: .local).midX
                let minY = geometry.frame(in: .local).midY
                let taichiWH = geometry.size.width * 0.35
                let bottomPad = geometry.size.width * 0.75
                let baseWidth = geometry.size.width * 0.2
                let baseHeight = geometry.size.width * 0.85
                
                TaiChiSymbol()
                    .frame(width: taichiWH, height: taichiWH, alignment: .center)
                    .position(x: midX, y: minY)
            
                ForEach(1..<5) { i in
                    BaseSymbol(id: i)
                        .padding(.bottom, bottomPad)
                        .frame(width: baseWidth, height: baseHeight)
                        .position(x: midX, y: minY)
                        .rotationEffect(.degrees(Double(9-i) / Double(8)) * 360.0, anchor: .center)

                    BaseSymbol(id: i + 4)
                        .padding(.bottom, bottomPad)
                        .frame(width: baseWidth, height: baseHeight)
                        .position(x: midX, y: minY)
                        .rotationEffect(.degrees(Double(i) / Double(8)) * 360.0, anchor: .center)
                }
            }
        }
    }
}

struct EightTrigramsSymbol_Previews: PreviewProvider {
    static var previews: some View {
        EightTrigramsSymbol()
            .frame(width: 250, height: 250, alignment: .center)
            .overlay(HexagramShape().stroke())
    }
}
