//
//  DigitalPredictionView.swift
//  Change
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DigitalPredictionView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.colorScheme) var colorScheme
    @State private var isSolve = false
    @State private var opcity: Double = 1
    private var uiWidth = UIScreen.main.nativeBounds.width
    private var uiHeight = UIScreen.main.nativeBounds.height
        
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text("数字卦")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                RotateImage(image: "先天八卦图", lineWidth: 2)
                    .frame(width: uiWidth * 0.3, height: uiWidth * 0.3)
                
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
                .padding(.horizontal, 5.0)
                
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
                                    
                    Spacer()
                }
            }
            .blur(radius: isSolve ? 15 : 0)
            
            if $isSolve.wrappedValue {
                VStack {
                    DigitalExplanationView(digitalData: modelData.digitalPrediction.data)
                        .cornerRadius(10).shadow(radius: 20)

                    Button(action: {
                        self.isSolve = false
                    }) {
                        Image(systemName: "xmark.seal")
                            .resizable()
                            .foregroundColor((colorScheme == .dark) ? .white : .black)
                            .frame(width: 50, height: 50)
                    }
                }
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

        let records = modelData.hexagramRecord.filter{ $0.type == RecordType.Digital.rawValue }

        if modelData.digitalPrediction.data != records.last?.digit {
            let recordData = RecordData(type: RecordType.Digital.rawValue, digit: modelData.digitalPrediction.data, date: Date())
            modelData.hexagramRecord.append(recordData)
            
            saveRecord(modelData.hexagramRecord)
        }
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        self.isSolve = true
    }
}

struct DigitalPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        DigitalPredictionView()
            .environmentObject(ModelData())
    }
}
