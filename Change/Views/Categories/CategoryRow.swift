//
//  CategoryRow.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct CategoryRow: View {
    var items: [Hexagram]
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items, id: \.self) { hexagram in
                        NavigationLink(destination: HexagramDetail(hexagram:  hexagram)) {
                            CategoryItem(hexagram: hexagram)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(
            items: Array(derivedHexagrams.prefix(4))
        )
    }
}
