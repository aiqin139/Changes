//
//  HexagramRow.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct HexagramRow: View {
    var items: [Hexagram]
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items, id: \.self) { hexagram in
                        NavigationLink(destination: HexagramDetail(hexagram:  hexagram)) {
                            HexagramItem(hexagram: hexagram)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct HexagramRow_Previews: PreviewProvider {
    static var previews: some View {
        HexagramRow(
            items: Array(hexagrams.prefix(4))
        )
    }
}
