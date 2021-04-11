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
                        Text(dayanData.benHexagram.pinyin)
                            .font(.title3)
                            .foregroundColor(.primary)
                        Text(dayanData.benHexagram.name)
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack {
                    }
                    .frame(width: 50)
                    
                    VStack {
                        Text(dayanData.zhiHexagram.pinyin)
                            .font(.title3)
                            .foregroundColor(.primary)
                        Text(dayanData.zhiHexagram.name)
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                HStack {
                    dayanData.benHexagram.image
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
                    
                    dayanData.zhiHexagram.image
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
            benHexagram: ModelData().derivedHexagrams[0],
            zhiHexagram: ModelData().derivedHexagrams[1],
            explanation1: ModelData().derivedHexagrams[0].explanations[0],
            explanation2: ModelData().derivedHexagrams[1].explanations[1]
        ))
    }
}
