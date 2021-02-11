//
//  DigitalExplanationView.swift
//  Change
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DigitalExplanationView: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        VStack {
            Text("数字卦")
                .font(.title)
                .foregroundColor(.primary)
            
            Text(modelData.digitalPrediction.hexagram.pinyin)
                .font(.title)
                .foregroundColor(.primary)
            Text(modelData.digitalPrediction.hexagram.name)
                .font(.title)
                .foregroundColor(.primary)
        
            modelData.digitalPrediction.hexagram.image
                .resizable()
                .frame(width: 400, height: 400)
            
            VStack(alignment: .leading) {
                ForEach(modelData.digitalPrediction.explanation, id: \.self) { content in
                    Text(content)
                        .padding(.horizontal, 10.0)
                        .minimumScaleFactor(0.1)
                }
            }
        }
    }
}

struct DigitalExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        DigitalExplanationView()
            .environmentObject(ModelData())
    }
}
