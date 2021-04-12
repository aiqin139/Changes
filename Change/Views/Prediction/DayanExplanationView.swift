//
//  DayanExplanationView.swift
//  Change
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DayanExplanationView: View {
    var dayanData: DayanData

    var body: some View {
        VStack {
            Spacer()
            
            Text("大衍卦")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
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
                                .border(Color(UIColor.separator))
                                .contentShape(Rectangle())
                                .shadow(radius: 15)
                        }
                    }
                    .frame(width: 50)
                    
                    Image(dayanData.zhiName)
                        .resizable()
                        .frame(width: 150, height: 150)
                }
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                ForEach(dayanData.explanation1, id: \.self) { content in
                    Text(content)
                        .font(.title3)
                        .padding(.horizontal, 10.0)
                        .minimumScaleFactor(0.1)
                }
                
                Text("").font(.title)
                
                ForEach(dayanData.explanation2, id: \.self) { content in
                    Text(content)
                        .font(.title3)
                        .padding(.horizontal, 10.0)
                        .minimumScaleFactor(0.1)
                }
            }
            
            Spacer()
        }
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
