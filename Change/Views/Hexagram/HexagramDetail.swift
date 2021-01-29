//
//  HexagramDetial.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct HexagramDetail: View {
    var hexagram: Hexagram

    var body: some View {
        ScrollView {
            CircleImage(image: hexagram.image)
                .offset(y: 0)
                .padding(.bottom, 0)
            
            VStack {
                Text(hexagram.pinyin)
                    .font(.title)
                    .foregroundColor(.primary)
                Text(hexagram.name)
                    .font(.title)
                    .foregroundColor(.primary)
            }
            
            VStack(alignment: .leading) {
                ForEach(hexagram.explanations, id: \.self) { contents in
                    Divider()
                    ForEach(contents, id: \.self) { content in
                        Text(content)
                            .padding(.leading)
                    }
                }
            }
        }
        .navigationTitle(hexagram.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HexagramDetail_Previews: PreviewProvider {
    static var previews: some View {
        HexagramDetail(hexagram: hexagrams[0])
    }
}
