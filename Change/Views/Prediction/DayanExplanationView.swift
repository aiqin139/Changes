//
//  DayanExplanationView.swift
//  Change
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DayanExplanationView: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        VStack {
            Text("大衍卦")
                .font(.title)
                .foregroundColor(.primary)
            
            HStack(alignment: .center) {
                VStack {
                    Text(modelData.dayanPrediction.benHexagram.pinyin)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Text(modelData.dayanPrediction.benHexagram.name)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                
                    modelData.dayanPrediction.benHexagram.image
                        .resizable()
                        .frame(width: 150, height: 150)
                }
                
                VStack {
                    ForEach(modelData.dayanPrediction.result.reversed(), id: \.self) { content in
                        Text(String(content))
                            .padding(.horizontal)
                            .minimumScaleFactor(0.5)
                            .offset(x: 0, y: 22)
                    }
                }
                
                VStack {
                    Text(modelData.dayanPrediction.zhiHexagram.pinyin)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Text(modelData.dayanPrediction.zhiHexagram.name)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                
                    modelData.dayanPrediction.zhiHexagram.image
                        .resizable()
                        .frame(width: 150, height: 150)
                }
            }
            
            VStack(alignment: .leading) {
                ForEach(modelData.dayanPrediction.explanation1, id: \.self) { content in
                    Text(content)
                        .font(.subheadline)
                        .padding(.horizontal, 10.0)
                        .minimumScaleFactor(0.1)
                }
                
                Text("").font(.title)
                
                ForEach(modelData.dayanPrediction.explanation2, id: \.self) { content in
                    Text(content)
                        .font(.subheadline)
                        .padding(.horizontal, 10.0)
                        .minimumScaleFactor(0.1)
                }
            }
        }
    }
}

struct DayanExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        DayanExplanationView()
            .environmentObject(ModelData())
    }
}
