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
    
    var dayanData: DayanData

    var body: some View {
        VStack(spacing: 20) {
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
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))

            HStack {
                VStack {
                    HexagramSymbol(id: dayanData.benId, type: dayanData.benType, strokeYaos: dayanData.changeYaos, strokeColor: .red)
                        .frame(width: 110, height: 140)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    ForEach(0..<6, id: \.self) { index in
                        if index == 3 { Text(" ") }
                        let res = dayanData.result[5 - index]
                        Text(String(res))
                            .font(.system(size: 18))
                            .foregroundColor((res == 6 || res == 9) ? .red : strokeColor)
                    }
                }
                .frame(width: 50)
                
                VStack {
                    HexagramSymbol(id: dayanData.zhiId, type: dayanData.zhiType, strokeYaos: dayanData.changeYaos, strokeColor: .red)
                        .frame(width: 110, height: 140)
                        .padding()
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(strokeColor, lineWidth: 2))
            
            VStack {
                VStack(alignment: .center) {
                    Text(dayanData.explanation1Name)
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        ForEach(dayanData.explanation1, id: \.self) { content in
                            Text(content)
                                .foregroundColor(content.range(of: dayanData.purpose) != nil ? .red : strokeColor)
                        }
                    }
                    
                    if dayanData.explanation2[0] != "" {
                        Divider()
                        
                        Text(dayanData.explanation2Name)
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            ForEach(dayanData.explanation2, id: \.self) { content in
                                Text(content)
                                    .foregroundColor(content.range(of: dayanData.purpose) != nil ? .red : strokeColor)
                            }
                        }
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
