//
//  HexagramDetail.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct HexagramDetail: View {
    @Environment(\.colorScheme) var colorScheme
        
    var backgroundColor: Color {
        return (colorScheme == .dark) ? .black : .white
    }
    
    var hexagram: Hexagram

    var body: some View {
        VStack {
            VStack {
                Image(hexagram.name)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .aspectRatio(contentMode: .fit)
            
                Text(hexagram.pinyin)
                    .font(.title)
                    .foregroundColor(.primary)
                    
                Text(hexagram.name)
                    .font(.title)
                    .foregroundColor(.primary)
            }
            .padding()

            ScrollView {
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
        }
        .frame(width: 350)
        .background(backgroundColor)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 10, x: 0, y: 3)
        .animation(.easeInOut)
        .navigationTitle(hexagram.name)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

struct HexagramDetail_Previews: PreviewProvider {
    static var previews: some View {
        HexagramDetail(hexagram: ModelData().basicHexagrams[0])
        HexagramDetail(hexagram: ModelData().derivedHexagrams[0])
    }
}
