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
    @State private var opcity: Double = 1
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("大衍卦")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            RotateImage(image: "先天八卦图")
                .frame(width: 350, height: 350)
            
            Spacer()
            
            Button(action: {}) {
                VStack {
                    RotateImage(image: "先天八卦图")
                         .frame(width: 80, height: 80)
                    
                    Text("按住开始占卦")
                }
                .opacity(self.opcity)
                .onTapGesture { opcity = 0.8 }
                .onLongPressGesture { DayanPrediction() }
            }
            .sheet(isPresented: $isPresented, content: {
                DayanExplanationView(dayanPrediction: modelData.dayanPrediction)
            })
        }
        .navigationTitle("大衍卦")
    }
    
    func DayanPrediction() {
        let hexagrams = modelData.derivedHexagrams
        modelData.dayanPrediction.Execute(hexagrams: hexagrams)
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        self.isPresented = true
    }
}

struct DayanPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        DayanPredictionView()
            .environmentObject(ModelData())
    }
}
