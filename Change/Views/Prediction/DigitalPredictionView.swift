//
//  DigitalPredictionView.swift
//  Change
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DigitalPredictionView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var value1: Int = 111
    @State private var value2: Int = 111
    @State private var value3: Int = 111
    @State private var isPresented = false
    @State private var opcity: Double = 1
    
    @State private var number: Int = 3
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("数字卦")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            RotateImage(image: "先天八卦图")
                .frame(width: 350, height: 350)
            
            Spacer()
            
            HStack {
                NumberPicker(label: "数字1:", start: 100, end: 999, value: $value1)
                NumberPicker(label: "数字2:", start: 100, end: 999, value: $value2)
                NumberPicker(label: "数字3:", start: 100, end: 999, value: $value3)
            }
            
            Spacer()
            
            Button(action: {}) {
                VStack {
                    RotateImage(image: "先天八卦图")
                         .frame(width: 80, height: 80)
                    
                    Text("按住开始解卦")
                }
                .opacity(self.opcity)
                .onTapGesture { opcity = 0.8 }
                .onLongPressGesture { DigitPrediction() }
            }
            .sheet(isPresented: $isPresented, content: {
                DigitalExplanationView(digitalPrediction: modelData.digitalPrediction)
                    .animation(.easeInOut(duration: 1.0))
            })
        }
    }
    
    func DigitPrediction() {
        let hexagrams = modelData.derivedHexagrams
        
        modelData.digitalPrediction.Execute(hexagrams: hexagrams, value1: value1, value2: value2, value3: value3)
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        self.isPresented = true
    }
}

struct DigitalPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        DigitalPredictionView()
            .environmentObject(ModelData())
    }
}
