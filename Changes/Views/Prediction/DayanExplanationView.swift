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
            HStack {
                VStack {
                    Text(dayanData.benPinyin)
                    Text(dayanData.benName + "(本)")
                }
                .frame(maxWidth: .infinity)

                VStack {
                }
                .frame(width: 50)
                
                VStack {
                    Text(dayanData.zhiPinyin)
                    Text(dayanData.zhiName + "(之)")
                }
                .frame(maxWidth: .infinity)
            }
                .font(.title2)
                .foregroundColor(.primary)
                .frame(width: 350)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
                .padding(.vertical, 15.0)

            VStack(alignment: .center) {
                HStack {
                    HexagramSymbol(id: dayanData.benId, type: dayanData.benType, strokeYaos: dayanData.changeYaos, strokeColor: .red)
                        .frame(width: 110, height: 140)
                        .padding()
                    
                    VStack(spacing: 5) {
                        ForEach(dayanData.result.reversed(), id: \.self) { content in
                            Text(String(content))
                                .font(.title3)
                                .padding(.horizontal)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
                                .foregroundColor((content == 6 || content == 9) ? .red : strokeColor)
                        }
                    }
                    .frame(width: 50)
                    
                    HexagramSymbol(id: dayanData.zhiId, type: dayanData.zhiType, strokeYaos: dayanData.changeYaos, strokeColor: .red)
                        .frame(width: 110, height: 140)
                        .padding()
                }
            }
            .frame(width: 350)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
            .padding(.vertical, -5.0)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(dayanData.explanation1, id: \.self) { content in
                        Text(content)
                            .font(.title3)
                            .padding(.horizontal, 10.0)
                            .minimumScaleFactor(0.1)
                            .foregroundColor(content.range(of: dayanData.purpose) != nil ? .red : strokeColor)
                    }
                    
                    if dayanData.explanation2[0] != "" {
                        Text("").font(.title)
                                    
                        ForEach(dayanData.explanation2, id: \.self) { content in
                            Text(content)
                                .font(.title3)
                                .padding(.horizontal, 10.0)
                                .minimumScaleFactor(0.1)
                                .foregroundColor(content.range(of: dayanData.purpose) != nil ? .red : strokeColor)
                        }
                    }
                }
                .padding(.vertical, 15.0)
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
