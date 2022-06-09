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
            let midX = geometry.frame(in: .local).midX
            let minY = geometry.frame(in: .local).midY
            let bigRadius = geometry.frame(in: .local).width * 0.5
            let mediumRadius = bigRadius * 0.5
            let smallRadius = bigRadius * 0.15
            
            Path { path in
                //左半圆
                path.move(to: CGPoint(x: midX, y: minY + bigRadius))
                path.addArc(center: CGPoint(x: midX, y: minY), radius: bigRadius, startAngle: .degrees(90), endAngle: .degrees(270), clockwise: false)

                //上半圆
                path.addArc(center: CGPoint(x: midX, y: minY - mediumRadius), radius: mediumRadius, startAngle: .degrees(270), endAngle: .degrees(90), clockwise: false)

                //下半圆
                path.addArc(center: CGPoint(x: midX, y: minY + mediumRadius), radius: mediumRadius, startAngle: .degrees(270), endAngle: .degrees(90), clockwise: true)
            }
            .stroke()

            Path { path in
                //右半圆
                path.move(to: CGPoint(x: midX, y: minY - bigRadius))
                path.addArc(center: CGPoint(x: midX, y: minY), radius: bigRadius, startAngle: .degrees(270), endAngle: .degrees(90), clockwise: false)

                //下半圆
                path.addArc(center: CGPoint(x: midX, y: minY + mediumRadius), radius: mediumRadius, startAngle: .degrees(90), endAngle: .degrees(270), clockwise: false)

                //上半圆
                path.addArc(center: CGPoint(x: midX, y: minY - mediumRadius), radius: mediumRadius, startAngle: .degrees(90), endAngle: .degrees(270), clockwise: true)
            }
            .fill()
            
            //上圆
            Path { path in
                path.move(to: CGPoint(x: midX + smallRadius, y: minY - mediumRadius))
                path.addArc(center: CGPoint(x: midX, y: minY - mediumRadius), radius: smallRadius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
            }
            .fill(.black)

            //下圆
            Path { path in
                path.move(to: CGPoint(x: midX + smallRadius, y: minY + mediumRadius))
                path.addArc(center: CGPoint(x: midX, y: minY + mediumRadius), radius: smallRadius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
            }
            .fill(.white)
        }
    }
}

struct EightTrigramsSymbol: View {
    
    var body: some View {
        ZStack {
            TaiChiSymbol()
                .frame(width: 190, height: 190, alignment: .center)
        
            ForEach(1..<5) { i in
                BaseSymbol(id: i)
                    .padding(.bottom, 400.0)
                    .frame(width: 100, height: 450)
                    .rotationEffect(.degrees(Double(9-i) / Double(8)) * 360.0, anchor: .center)
                
                BaseSymbol(id: i + 4)
                    .padding(.bottom, 400.0)
                    .frame(width: 100, height: 450)
                    .rotationEffect(.degrees(Double(i) / Double(8)) * 360.0, anchor: .center)
            }
        }
    }
}

struct EightTrigramsSymbol_Previews: PreviewProvider {
    static var previews: some View {
        EightTrigramsSymbol()
    }
}
