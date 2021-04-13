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
            
            RotateImage(image: "先天八卦图", lineWidth: 2)
                .frame(width: 350, height: 350)
            
            Spacer()
            
            HStack {
                ForEach(0...2, id: \.self) { index in
                    VStack {
                        Text("数字" + String(index + 1))
                        NumberPicker(format: "%03d", start: 0, end: 999, value: $modelData.digitalPrediction.data.values[index])
                            .font(.title)
                            .clipShape(HexagramShape())
                            .overlay(HexagramShape().stroke(Color.black, lineWidth: 2))
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {}) {
                    VStack {
                        Image("占")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(HexagramShape())
                            .overlay(HexagramShape().stroke(Color.black, lineWidth: 2))
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
                            .frame(width: 80, height: 80)
                            .clipShape(HexagramShape())
                            .overlay(HexagramShape().stroke(Color.black, lineWidth: 2))
                    }
                    .opacity(self.opcity)
                    .onTapGesture { opcity = 0.8 }
                    .onLongPressGesture { DigitParser() }
                }
                .sheet(isPresented: $isPresented, content: {
                    DigitalExplanationView(digitalData: modelData.digitalPrediction.data)
                })
                
                Spacer()
            }
        }
        .shadow(radius: 20)
    }
    
    func DigitPrediction() {
        modelData.digitalPrediction.Execute()
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func DigitParser() {
        let hexagrams = modelData.derivedHexagrams
        modelData.digitalPrediction.Parser(hexagrams: hexagrams)
        
        if modelData.digitalPrediction.data != modelData.hexagramRecord.last?.digit {
            let recordData = RecordData(type: RecordType.Digital.rawValue, digit: modelData.digitalPrediction.data, date: Date())
            modelData.hexagramRecord.append(recordData)
            
            saveRecord(modelData.hexagramRecord)
        }
        
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
