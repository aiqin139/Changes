//
//  PredictionView.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct PredictionView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var val1Str: String = "0"
    @State private var val2Str: String = "0"
    @State private var val3Str: String = "0"
    
    var body: some View {
        VStack {
           Image("先天八卦图")
                .resizable()
                .frame(width: 400, height: 400)
            
            Label("数字卦", systemImage: "bolt.fill")
                .labelStyle(TitleOnlyLabelStyle())
            
            HStack(alignment: .center) {
                NumberInput(labelText: "数字1:", value: $val1Str)
                NumberInput(labelText: "数字2:", value: $val2Str)
                NumberInput(labelText: "数字3:", value: $val3Str)
            }
            
            Button(action: { DigitPrediction() }, label: {
                Image("先天八卦图")
                     .resizable()
                     .frame(width: 80, height: 80)
            })
        }
    }
    
    func DigitPrediction() {
        let hexagrams = modelData.derivedHexagrams
        
        let val1 = Int(val1Str) ?? 0
        let val2 = Int(val2Str) ?? 0
        let val3 = Int(val3Str) ?? 0
        
        modelData.prediction.DigitPrediction(hexagrams: hexagrams, value1: val1, value2: val2, value3: val3)
    }
}

struct PredictionView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionView()
            .environmentObject(ModelData())
    }
}
