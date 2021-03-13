//
//  DayanExplanationView.swift
//  Change
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DayanExplanationView: View {
    var dayanPrediction: DayanPrediction

    var body: some View {
        VStack {
            Spacer()
            
            Text("大衍卦")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            VStack(alignment: .center) {
                HStack {
                    VStack {
                        Text(dayanPrediction.benHexagram.pinyin)
                            .font(.title3)
                            .foregroundColor(.primary)
                        Text(dayanPrediction.benHexagram.name)
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack {
                    }
                    .frame(width: 50)
                    
                    VStack {
                        Text(dayanPrediction.zhiHexagram.pinyin)
                            .font(.title3)
                            .foregroundColor(.primary)
                        Text(dayanPrediction.zhiHexagram.name)
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                HStack {
                    dayanPrediction.benHexagram.image
                        .resizable()
                        .frame(width: 150, height: 150)
                    
                    VStack {
                        ForEach(dayanPrediction.result.reversed(), id: \.self) { content in
                            Text(String(content))
                                .font(.title3)
                                .padding(.horizontal)
                                .border(Color(UIColor.separator))
                                .contentShape(Rectangle())
                                .shadow(radius: 15)
                        }
                    }
                    .frame(width: 50)
                    
                    dayanPrediction.zhiHexagram.image
                        .resizable()
                        .frame(width: 150, height: 150)
                }
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                ForEach(dayanPrediction.explanation1, id: \.self) { content in
                    Text(content)
                        .font(.title3)
                        .padding(.horizontal, 10.0)
                        .minimumScaleFactor(0.1)
                }
                
                Text("").font(.title)
                
                ForEach(dayanPrediction.explanation2, id: \.self) { content in
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
        DayanExplanationView(dayanPrediction: DayanPrediction(
            benHexagram: ModelData().derivedHexagrams[0],
            zhiHexagram: ModelData().derivedHexagrams[1],
            explanation1: ModelData().derivedHexagrams[0].explanations[0],
            explanation2: ModelData().derivedHexagrams[1].explanations[1]
        ))
    }
}
