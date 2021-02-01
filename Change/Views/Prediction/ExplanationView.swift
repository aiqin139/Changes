//
//  ExplanationView.swift
//  Change
//
//  Created by aiqin139 on 2021/1/30.
//

import SwiftUI

struct ExplanationView: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        VStack {            
            Text(modelData.prediction.hexagram.pinyin)
                .font(.title)
                .foregroundColor(.primary)
            Text(modelData.prediction.hexagram.name)
                .font(.title)
                .foregroundColor(.primary)
        
            modelData.prediction.hexagram.image
                .resizable()
                .frame(width: 400, height: 400)
            
            VStack(alignment: .leading) {
                ForEach(modelData.prediction.explanation, id: \.self) { content in
                    Text(content)
                        .padding(.horizontal, 10.0)
                        .minimumScaleFactor(0.1)
                }
            }
        }
    }
}

struct ExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        ExplanationView()
            .environmentObject(ModelData())
    }
}
