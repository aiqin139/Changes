//
//  DayanPredictionView.swift
//  Change
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DayanPredictionView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        VStack {
            Label("大衍卦", systemImage: "bolt.fill")
                .labelStyle(TitleOnlyLabelStyle())
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    DayanPrediction()
                }
            }, label: {
                Image("先天八卦图")
                     .resizable()
                     .frame(width: 80, height: 80)
            })
            
            Spacer()
        }
    }
    
    func DayanPrediction() {
        let hexagrams = modelData.derivedHexagrams
        modelData.dayanPrediction.Execute(hexagrams: hexagrams)
    }
}

struct DayanPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        DayanPredictionView()
            .environmentObject(ModelData())
    }
}
