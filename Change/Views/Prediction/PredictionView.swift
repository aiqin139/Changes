//
//  PredictionView.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct PredictionView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        VStack {
            
            PageView(pages: [PredictionViews(digital: 1), PredictionViews(digital: 0)])
                .aspectRatio(1 / 1.8, contentMode: .fit)
        }
    }
}

struct PredictionViews: View {
    @EnvironmentObject var modelData: ModelData
    var digital = 1
    
    var body: some View {
        VStack {
            Image("先天八卦图")
                 .resizable()
                 .frame(width: 400, height: 400)

            if digital == 1 {
                DigitalPredictionView()
                    .environmentObject(modelData)
            }
            else {
                DayanPredictionView()
                    .environmentObject(modelData)
            }
        }
    }
}

struct PredictionView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionView()
            .environmentObject(ModelData())
    }
}
