//
//  DigitalExplanationView.swift
//  Changes
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DigitalExplanationView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var strokeColor: Color {
        return (colorScheme == .dark) ? .white : .black
    }
    
    var digitalData: DigitalData

    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text(digitalData.pinyin)
                Text(digitalData.name)
            }
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .frame(maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
            
            VStack {
                HStack {
                    ForEach(digitalData.values, id: \.self) { content in
                        Text(String(content))
                            .font(.title)
                            .padding(.horizontal)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
                    }
                }
                .padding()

                HexagramSymbol(id: digitalData.id, type: digitalData.type, strokeYaos: digitalData.changeYao, strokeColor: .red)
                    .frame(width: 160, height: 160)
                
                HStack {
                    ForEach(digitalData.result, id: \.self) { content in
                        Text(String(content))
                            .font(.title)
                            .padding(.horizontal)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(digitalData.explanation, id: \.self) { content in
                        Text(content)
                            .foregroundColor(content.range(of: digitalData.purpose) != nil ? .red : strokeColor)
                    }
                }
                .font(.title3)
                .padding()
            }
            .frame(maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct DigitalExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        DigitalExplanationView(digitalData: DigitalData(
            name: ModelData().derivedHexagrams[0].name,
            pinyin: ModelData().derivedHexagrams[0].pinyin,
            explanation: ModelData().derivedHexagrams[0].explanations[0]
        ))
    }
}
