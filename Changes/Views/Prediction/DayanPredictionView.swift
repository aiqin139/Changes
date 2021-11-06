//
//  DayanPredictionView.swift
//  Changes
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DayanPredictionView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.colorScheme) var colorScheme
    @State private var isSolve = false
    @State private var isQuestion = false
    @State private var opcity: Double = 1
    private var yao: [String] = ["初", "二", "三", "四", "五", "上"]
    
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
                        ForEach(0...5, id: \.self) { index in
                            VStack {
                                let name = (((modelData.dayanPrediction.data.result[index] % 2) == 0) ? "六" : "九")
                                if (index == 0 || index == 5) {
                                    Text(yao[index] + name)
                                }
                                else {
                                    Text(name + yao[index])
                                }
                                NumberPicker(start: 6, end: 9, value: $modelData.dayanPrediction.data.result[index])
                                    .font(.title)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(accentColor, lineWidth: 2))
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
                            .onLongPressGesture { DayanPrediction() }
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
                            .onLongPressGesture { DayanParser() }
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                .blur(radius: (isSolve || isQuestion) ? 10 : 0)
                .disabled((isSolve || isQuestion) ? true : false)
                
                if $isSolve.wrappedValue {
                    VStack {
                        DayanExplanationView(dayanData: modelData.dayanPrediction.data)
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
                        RTFView(fileName: "大衍占法")
                        
                        Button(action: {
                            self.isQuestion = false
                        }) {
                            Image(systemName: "xmark.seal")
                                .resizable()
                                .foregroundColor(accentColor)
                                .frame(width: 50, height: 50)
                        }
                    }
                }
            }
            .shadow(radius: 20)
            .navigationTitle("大衍卦")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                self.isQuestion = true
            }) {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(accentColor)
            })
        }
    }
    
    func DayanPrediction() {
        modelData.dayanPrediction.Execute()
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func DayanParser() {
        let hexagrams = modelData.derivedHexagrams
        modelData.dayanPrediction.data.purpose = modelData.fortuneTellingPurpose
        modelData.dayanPrediction.Parser(hexagrams: hexagrams)
        
        let records = modelData.hexagramRecord.filter{ $0.type == RecordType.Dayan.rawValue }
        
        if modelData.dayanPrediction.data != records.last?.dayan {
            let recordData = RecordData(type: RecordType.Dayan.rawValue, dayan: modelData.dayanPrediction.data, date: Date())
            modelData.hexagramRecord.append(recordData)
            
            saveRecord(modelData.hexagramRecord)
        }
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        self.isSolve = true
    }
}

struct DayanPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        DayanPredictionView()
            .environmentObject(ModelData())
    }
}
