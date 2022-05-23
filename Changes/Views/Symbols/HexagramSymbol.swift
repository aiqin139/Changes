//
//  HexagramSymbol.swift
//  Changes
//
//  Created by aiqin139 on 2022/5/23.
//

import SwiftUI

struct YinSymbol: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let spacing = geometry.size.width * 0.05
                let width = geometry.size.width / 2
                let height = geometry.size.height
                
                path.addRect(CGRect(x: 0, y: 0, width: width - spacing, height: height))
                path.addRect(CGRect(x: width + spacing, y: 0, width: width - spacing, height: height))
            }
        }
    }
}

struct YangSymbol: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                path.addRect(CGRect(x: 0, y: 0, width: width, height: height))
            }
        }
    }
}

struct BaseSymbol: View {
    var id: Int = 1
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height * 0.12) {
                ForEach(0...2, id: \.self) { index in
                    if ((id - 1) >> index & 1 == 0) {
                        YangSymbol()
                    } else {
                        YinSymbol()
                    }
                }
            }
        }
    }
}

struct DerivedSymbol: View {
    var id: Int = 1
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height * 0.15) {
                BaseSymbol(id: id & 7)
                BaseSymbol(id: ((id - 1) >> 3) & 7 + 1)
            }
        }
    }
}

struct HexagramSymbol: View {
    var id: Int = 1
    var type: String = "base"
    
    var body: some View {
        VStack {
            if (type == "base") {
                BaseSymbol(id: id)
            } else {
                DerivedSymbol(id: id)
            }
        }
    }
}

struct HexagramSymbol_Previews: PreviewProvider {
    static var previews: some View {
        BaseSymbol()
            .frame(width: 150, height: 100, alignment: .center)
        DerivedSymbol()
            .frame(width: 150, height: 200, alignment: .center)
    }
}
