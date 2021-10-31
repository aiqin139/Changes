//
//  CategoryItem.swift
//  Changes
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct CategoryItem: View {
    @Environment(\.colorScheme) var colorScheme
    
    var accentColor: Color {
        return (colorScheme == .dark) ? .white : .black
    }
    
    var hexagram: Hexagram
    
    var body: some View {
        VStack(alignment: .center) {
            Image(hexagram.name)
                .renderingMode(.original)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(5)
            Text(hexagram.name)
                .accentColor(accentColor)
            Text(hexagram.description)
                .accentColor(accentColor)
        }
        .frame(width: 150)
        .padding(.all, 20)
        .background(Color(white: 0.99))
        .cornerRadius(10)
        .shadow(color: .gray, radius: 1, x: 0, y: 0)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(hexagram: ModelData().derivedHexagrams[0])
    }
}
