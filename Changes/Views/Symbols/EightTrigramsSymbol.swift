//
//  EightTrigramsSymbol.swift
//  Changes
//
//  Created by aiqin139 on 2022/6/9.
//

import SwiftUI

struct TaiChiSymbol: View {
    var body: some View {
        GeometryReader { geometry in
            let midX = geometry.size.width * 0.5
            let minY = geometry.size.height * 0.5
            let bigRadius = geometry.size.width * 0.5
            let mediumRadius = bigRadius * 0.5
            let smallRadius = bigRadius * 0.15
            
            Path { path in
                //左半圆
                path.move(to: CGPoint(x: midX, y: minY + bigRadius))
                path.addArc(center: CGPoint(x: midX, y: minY), radius: bigRadius, startAngle: .degrees(90), endAngle: .degrees(630), clockwise: false)

                //上半圆
                path.addArc(center: CGPoint(x: midX, y: minY - mediumRadius), radius: mediumRadius, startAngle: .degrees(270), endAngle: .degrees(90), clockwise: false)

                //下半圆
                path.addArc(center: CGPoint(x: midX, y: minY + mediumRadius), radius: mediumRadius, startAngle: .degrees(270), endAngle: .degrees(90), clockwise: true)
                
                //上圆
                path.move(to: CGPoint(x: midX + smallRadius, y: minY - mediumRadius))
                path.addArc(center: CGPoint(x: midX, y: minY - mediumRadius), radius: smallRadius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
                
                //下圆
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
    }
}
