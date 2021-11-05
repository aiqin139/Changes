//
//  DayanExplanationView.swift
//  Changes
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DayanExplanationView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var strokeColor: Color {
        return (colorScheme == .dark) ? .white : .black
    }
    
    var backgroundColor: Color {
        return (colorScheme == .dark) ? .black : .white
    }
    
    var dayanData: DayanData

    var body: some View {
        VStack {
            Text("大衍卦")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .frame(width: 350)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
                .padding(.vertical, 15.0)

            VStack(alignment: .center) {
                HStack {
                    VStack {
                        Text(dayanData.benPinyin)
                            .font(.title3)
                            .foregroundColor(.primary)
                        Text(dayanData.benName)
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack {
                    }
                    .frame(width: 50)
                    
                    VStack {
                        Text(dayanData.zhiPinyin)
                            .font(.title3)
                            .foregroundColor(.primary)
                        Text(dayanData.zhiName)
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                HStack {
                    Image(dayanData.benName)
                        .resizable()
                        .frame(width: 150, height: 150)
                    
                    VStack {
                        ForEach(dayanData.result.reversed(), id: \.self) { content in
                            Text(String(content))
                                .font(.title3)
                                .padding(.horizontal)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
                        }
                    }
                    .frame(width: 50)
                    
                    Image(dayanData.zhiName)
                        .resizable()
                        .frame(width: 150, height: 150)
                }
            }
            .frame(width: 350, height: 250)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
            .padding(.vertical, -5.0)
            
            
            VStack(alignment: .leading) {
                ForEach(dayanData.explanation1, id: \.self) { content in
                    Text(content)
                        .font(.title3)
                        .padding(.horizontal, 10.0)
                        .minimumScaleFactor(0.1)
                }
                
                if dayanData.explanation2[0] != "" {
                    Text("").font(.title)
                                
                    ForEach(dayanData.explanation2, id: \.self) { content in
                        Text(content)
                            .font(.title3)
                            .padding(.horizontal, 10.0)
                            .minimumScaleFactor(0.1)
                    }
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

struct DayanExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        DayanExplanationView(dayanData: DayanData(
            benName: ModelData().derivedHexagrams[0].name,
            benPinyin: ModelData().derivedHexagrams[0].pinyin,
            zhiName: ModelData().derivedHexagrams[1].name,
            zhiPinyin: ModelData().derivedHexagrams[1].pinyin,
            explanation1: ModelData().derivedHexagrams[0].explanations[0],
            explanation2: ModelData().derivedHexagrams[1].explanations[1]
        ))
    }
}
