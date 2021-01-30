//
//  CategoryMatrix.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct CategoryMatrix: View {
    var hexagrams: [Hexagram] = derivedHexagrams
    
    var body: some View {
        NavigationView() {
            ScrollView(.vertical, showsIndicators: false) {
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(0...7, id: \.self) { vindex in
                            HStack(alignment: .top, spacing: 0) {
                                ForEach(0...7, id: \.self) { hindex in
                                    let hexagram: Hexagram = hexagrams[vindex * 8 + hindex]
                                    NavigationLink(destination: HexagramDetail(hexagram: hexagram)) {
                                        CategoryItem(hexagram: hexagram)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("六十四卦")
        }
    }
}

struct CategoryMatrix_Previews: PreviewProvider {
    static var previews: some View {
        CategoryMatrix()
    }
}
