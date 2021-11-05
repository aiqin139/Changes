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
    
    var backgroundColor: Color {
        return (colorScheme == .dark) ? .black : .white
    }
    
    var digitalData: DigitalData

    var body: some View {
        VStack {
            Text("数字卦")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .frame(width: 350)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
                .padding(.vertical, 15.0)
            
            VStack {
                Text(digitalData.pinyin)
                    .font(.title)
                Text(digitalData.name)
                    .font(.title)
            
                Image(digitalData.name)
                    .resizable()
                    .frame(width: 180, height: 180)
                
                HStack {
                    ForEach(digitalData.values, id: \.self) { content in
                        Text(String(content))
                            .font(.title)
                            .padding(.horizontal)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
                    }
                }
                
                Spacer()
                
                HStack {
                    ForEach(digitalData.result, id: \.self) { content in
                        Text(String(content))
                            .font(.title)
                            .padding(.horizontal)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
                    }
                }
                
                Spacer()
            }
            .frame(width: 350, height: 350)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
            .padding(.vertical, -5.0)
            
            VStack(alignment: .leading) {
                ForEach(digitalData.explanation, id: \.self) { content in
                    Text(content)
                        .font(.title3)
                        .padding(.horizontal, 10.0)
                        .minimumScaleFactor(0.1)
                }
            }
            .frame(width: 350)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
            .padding(.vertical, 15.0)
        }
        .frame(width: 350)
        .shadow(color: .gray, radius: 10)
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
