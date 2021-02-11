//
//  DigitalPredictionView.swift
//  Change
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DigitalPredictionView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var val1Str: String = "000"
    @State private var val2Str: String = "000"
    @State private var val3Str: String = "000"
    
    var body: some View {
        VStack {
            Label("数字卦", systemImage: "bolt.fill")
                .labelStyle(TitleOnlyLabelStyle())
            
            HStack(alignment: .center) {
                NumberInput(labelText: "数字1:", value: $val1Str)
                NumberInput(labelText: "数字2:", value: $val2Str)
                NumberInput(labelText: "数字3:", value: $val3Str)
            }
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    DigitPrediction()
                }
            }, label: {
                Image("先天八卦图")
                     .resizable()
                     .frame(width: 80, height: 80)
            })
            
            Spacer()
        }
    }
    
    func DigitPrediction() {
        let hexagrams = modelData.derivedHexagrams
        
        let val1 = Int(val1Str) ?? 0
        let val2 = Int(val2Str) ?? 0
        let val3 = Int(val3Str) ?? 0
        
        modelData.digitalPrediction.Execute(hexagrams: hexagrams, value1: val1, value2: val2, value3: val3)
    }
}

struct DigitalPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        DigitalPredictionView()
            .environmentObject(ModelData())
    }
}
