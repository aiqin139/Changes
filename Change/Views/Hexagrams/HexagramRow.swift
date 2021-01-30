//
//  HexagramRow.swift
//  Change
//
//  Created by aiqin139 on 2021/1/29.
//

import SwiftUI

struct HexagramRow: View {
    var hexagram: Hexagram
    
    var body: some View {
        HStack {
            hexagram.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(hexagram.name)
            Text(hexagram.description)
            
            Spacer()
        }
    }
}

struct HexagramRow_Previews: PreviewProvider {
    static var previews: some View {
        HexagramRow(hexagram: derivedHexagrams[0])
            .previewLayout(.fixed(width: 300, height: 50))
    }
}
