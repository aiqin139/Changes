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
            HStack(alignment: .center) {
                VStack {
                    Text(dayanPrediction.benHexagram.pinyin)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Text(dayanPrediction.benHexagram.name)
                        .font(.subheadline)
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
                            .offset(x: 0, y: 22)
                    }
                }
                
                VStack {
                    Text(dayanPrediction.zhiHexagram.pinyin)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Text(dayanPrediction.zhiHexagram.name)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                
                    dayanPrediction.zhiHexagram.image
                        .resizable()
                        .frame(width: 150, height: 150)
                }
            }
            
            VStack(alignment: .leading) {
                ForEach(dayanPrediction.explanation1, id: \.self) { content in
                    Text(content)
                        .font(.subheadline)
                        .padding(.horizontal, 10.0)
                        .minimumScaleFactor(0.1)
                }
                
                Text("").font(.title)
                
                ForEach(dayanPrediction.explanation2, id: \.self) { content in
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
        DayanExplanationView(dayanPrediction: DayanPrediction())
    }
}
