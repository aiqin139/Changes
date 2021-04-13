//
//  HexagramDetail.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct HexagramDetail: View {
    var hexagram: Hexagram

    var body: some View {
        ScrollView {
            CircleImage(image: hexagram.name)
                .offset(y: 10)
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
                            .padding(.horizontal, 10.0)
                            .minimumScaleFactor(0.1)
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
        HexagramDetail(hexagram: ModelData().basicHexagrams[0])
        HexagramDetail(hexagram: ModelData().derivedHexagrams[0])
    }
}
