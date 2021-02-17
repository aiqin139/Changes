//
//  DigitalExplanationView.swift
//  Change
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DigitalExplanationView: View {
    var digitalPrediction: DigitalPrediction

    var body: some View {
        VStack {
            Spacer()
            
            Text("数字卦")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            Text(digitalPrediction.hexagram.pinyin)
                .font(.title)
                .foregroundColor(.primary)
            Text(digitalPrediction.hexagram.name)
                .font(.title)
                .foregroundColor(.primary)
        
            digitalPrediction.hexagram.image
                .resizable()
                .frame(width: 250, height: 250)
            
            VStack(alignment: .leading) {
                ForEach(digitalPrediction.explanation, id: \.self) { content in
                    Text(content)
                        .font(.title3)
                        .padding(.horizontal, 10.0)
                        .minimumScaleFactor(0.1)
                }
            }
            
            Spacer()
            Spacer()
        }
    }
}

struct DigitalExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        DigitalExplanationView(digitalPrediction: DigitalPrediction())
    }
}
