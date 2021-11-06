//
//  DigitalPredictionView.swift
//  Changes
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DigitalPredictionView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.colorScheme) var colorScheme
    @State private var isSolve = false
    @State private var isQuestion = false
    @State private var opcity: Double = 1
    
    var accentColor: Color {
        return (colorScheme == .dark) ? .white : .black
    }
    
    var body: some View {
        GeometryReader { geometry in
            let imageWidth = geometry.size.height * 0.45
            let imageHeight = geometry.size.height * 0.45
            let buttonWidth = geometry.size.height * 0.1
            let buttonHeight = geometry.size.height * 0.1
            
            ZStack {
                VStack {
                    Spacer()
                    
                    RotateImage(image: "先天八卦图", lineWidth: 2)
                        .frame(width: imageWidth, height: imageHeight)
                    
                    Spacer()
                    
                    HStack {
                        ForEach(0...2, id: \.self) { index in
                            VStack {
                                Text("数字" + String(index + 1))
                                NumberPicker(format: "%03d", start: 0, end: 999, value: $modelData.digitalPrediction.data.values[index])
                                    .font(.title)
                                    .clipShape(HexagramShape())
                                    .overlay(HexagramShape().stroke(accentColor, lineWidth: 2))
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
                                    .frame(width: buttonWidth, height: buttonHeight)
                                    .clipShape(HexagramShape())
                                    .overlay(HexagramShape().stroke(accentColor, lineWidth: 2))
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
                                    .frame(width: buttonWidth, height: buttonHeight)
                                    .clipShape(HexagramShape())
                                    .overlay(HexagramShape().stroke(accentColor, lineWidth: 2))
                            }
                            .opacity(self.opcity)
                            .onTapGesture { opcity = 0.8 }
                            .onLongPressGesture { DigitParser() }
                        }

                        Spacer()
                    }
                    
                    Spacer()
                }
                .blur(radius: (isSolve || isQuestion) ? 10 : 0)
                .disabled((isSolve || isQuestion) ? true : false)
                
                if $isSolve.wrappedValue {
                    VStack {
                        DigitalExplanationView(digitalData: modelData.digitalPrediction.data)
                            .cornerRadius(10).shadow(radius: 20)

                        Button(action: {
                            self.isSolve = false
                        }) {
                            Image(systemName: "xmark.seal")
                                .resizable()
                                .foregroundColor(accentColor)
                                .frame(width: 50, height: 50)
                        }
                    }
                }

                if $isQuestion.wrappedValue {
                    VStack {
                        Text("自定占法：")
                        Text("滑动三个数字滑轮数字，长按“解”进行解卦。")
                        Text("")
                        Text("随机占法：")
                        Text("长按“占”进行随机占卦，长按“解”进行解卦。")
                    }
                }
            }
            .shadow(radius: 20)
            .navigationTitle("数字卦")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                if self.isSolve == false { self.isQuestion = true }
            }) {
                    Image(systemName: "questionmark.circle")
            })
            .onTapGesture { self.isQuestion = false }
        }
    }
    
    func DigitPrediction() {
        modelData.digitalPrediction.Execute()
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func DigitParser() {
        let hexagrams = modelData.derivedHexagrams
        modelData.digitalPrediction.data.purpose = modelData.fortuneTellingPurpose
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
