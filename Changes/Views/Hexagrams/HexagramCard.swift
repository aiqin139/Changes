//
//  HexagramCard.swift
//  Changes
//
//  Created by aiqin139 on 2021/7/9.
//

import SwiftUI

struct HexagramCard: View {
    var hexagram: Hexagram
    @State var fold = true
    
    var body: some View {
        VStack {
            Image(hexagram.name)
                .resizable()
                .frame(height: 150, alignment: .center)
                .aspectRatio(contentMode: .fit)
            
            VStack {
                Text(hexagram.pinyin)
                    .font(.title)
                    .foregroundColor(.primary)
                    
                Text(hexagram.name)
                    .font(.title)
                    .foregroundColor(.primary)
            }
            .padding()
            
            if fold == false {
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
                .padding()
            }
        }
        .frame(width: fold ? 280 : 350)
        .background(Color(white: 0.99))
        .cornerRadius(10)
        .shadow(color: .gray, radius: 10, x: 0, y: 3)
        .animation(.easeInOut)
        .onTapGesture {
            self.fold.toggle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        HexagramCard(hexagram: ModelData().basicHexagrams[0])
        HexagramCard(hexagram: ModelData().derivedHexagrams[0])
    }
}
