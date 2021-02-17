//
//  DayanPredictionView.swift
//  Change
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DayanPredictionView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            Button(action: DayanPrediction) {
                VStack {
                   Image("先天八卦图")
                         .resizable()
                         .frame(width: 80, height: 80)
                    
                    Text("按住开始占卦")
                }
            }.sheet(isPresented: $isPresented, content: {
                DayanExplanationView()
                    .environmentObject(modelData)
            })
        }
    }
    
    func DayanPrediction() {
        let hexagrams = modelData.derivedHexagrams
        modelData.dayanPrediction.Execute(hexagrams: hexagrams)
        self.isPresented = true
    }
}

struct DayanPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        DayanPredictionView()
            .environmentObject(ModelData())
    }
}
