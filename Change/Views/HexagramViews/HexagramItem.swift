//
//  HexagramItem.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct HexagramItem: View {
    var hexagram: Hexagram
    
    var body: some View {
        VStack(alignment: .center) {
            hexagram.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(5)
            Text(hexagram.name)
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding([.top, .leading, .trailing], 15)
    }
}

struct HexagramItem_Previews: PreviewProvider {
    static var previews: some View {
        HexagramItem(hexagram: hexagrams[0])
    }
}
