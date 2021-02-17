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
            
            HStack(alignment: .center) {
                VStack {
                    Text(dayanPrediction.benHexagram.pinyin)
                        .font(.title3)
                        .foregroundColor(.primary)
                    Text(dayanPrediction.benHexagram.name)
                        .font(.title3)
                        .foregroundColor(.primary)
                
                    dayanPrediction.benHexagram.image
                        .resizable()
                        .frame(width: 150, height: 150)
                }
                
                VStack {
                    ForEach(dayanPrediction.result.reversed(), id: \.self) { content in
                        Text(String(content))
                            .padding(.horizontal)
                            .minimumScaleFactor(0.5)
                            .offset(x: 0, y: 25)
                    }
                }
                
                VStack {
                    Text(dayanPrediction.zhiHexagram.pinyin)
                        .font(.title3)
                        .foregroundColor(.primary)
                    Text(dayanPrediction.zhiHexagram.name)
                        .font(.title3)
                        .foregroundColor(.primary)
                
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
        DayanExplanationView(dayanPrediction: DayanPrediction())
    }
}
