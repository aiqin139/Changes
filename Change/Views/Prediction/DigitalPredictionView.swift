//
//  DigitalPredictionView.swift
//  Change
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DigitalPredictionView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var isPresented = false
    @State private var opcity: Double = 1
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("数字卦")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            RotateImage(image: "先天八卦图")
                .frame(width: 350, height: 350)
            
            Spacer()
            
            HStack {
                NumberPicker(label: "数字1:", format: "%03d", start: 0, end: 999, value: $modelData.digitalPrediction.values[0])
                NumberPicker(label: "数字2:", format: "%03d", start: 0, end: 999, value: $modelData.digitalPrediction.values[1])
                NumberPicker(label: "数字3:", format: "%03d", start: 0, end: 999, value: $modelData.digitalPrediction.values[2])
            }
            .animation(nil)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {}) {
                    VStack {
                        Image("占")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                    }
                    .opacity(self.opcity)
                    .onTapGesture { opcity = 0.8 }
                    .onLongPressGesture { DigitPrediction() }
                }
                
                Spacer()
                
                Button(action: {}) {
                    VStack {
                        Image("解")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                    }
                    .opacity(self.opcity)
                    .onTapGesture { opcity = 0.8 }
                    .onLongPressGesture { DigitParser() }
                }
                .sheet(isPresented: $isPresented, content: {
                    DigitalExplanationView(digitalPrediction: modelData.digitalPrediction)
                        .animation(.easeInOut(duration: 1.0))
                })
                
                Spacer()
            }
        }
    }
    
    func DigitPrediction() {
        modelData.digitalPrediction.Execute()
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func DigitParser() {
        let hexagrams = modelData.derivedHexagrams
        modelData.digitalPrediction.Parser(hexagrams: hexagrams)
        
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
