//
//  CategoryItem.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct CategoryItem: View {
    var hexagram: Hexagram
    
    var body: some View {
        VStack(alignment: .center) {
            Image(hexagram.name)
                .renderingMode(.original)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(5)
            Text(hexagram.name)
            Text(hexagram.description)
        }
        .padding([.top, .leading, .trailing], 15)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(hexagram: ModelData().derivedHexagrams[0])
    }
}
