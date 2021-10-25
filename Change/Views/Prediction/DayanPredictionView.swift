//
//  DayanPredictionView.swift
//  Change
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DayanPredictionView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.colorScheme) var colorScheme
    @State private var isSolve = false
    @State private var opcity: Double = 1
    private var yao: [String] = ["初", "二", "三", "四", "五", "上"]
        
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()
                    
                    Text("大衍卦")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                    RotateImage(image: "先天八卦图", lineWidth: 2)
                        .frame(width: geometry.size.height * 0.45, height: geometry.size.height * 0.45)
                    
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
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
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
                                    .frame(width: geometry.size.height * 0.1, height: geometry.size.height * 0.1)
                                    .clipShape(HexagramShape())
                                    .overlay(HexagramShape().stroke(Color.black, lineWidth: 2))
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
                                    .frame(width: geometry.size.height * 0.1, height: geometry.size.height * 0.1)
                                    .clipShape(HexagramShape())
                                    .overlay(HexagramShape().stroke(Color.black, lineWidth: 2))
                            }
                            .opacity(self.opcity)
                            .onTapGesture { opcity = 0.8 }
                            .onLongPressGesture { DayanParser() }
                        }
                        
                        Spacer()
                    }
                }
                .blur(radius: isSolve ? 15 : 0)
                
                if $isSolve.wrappedValue {
                    VStack {
                        DayanExplanationView(dayanData: modelData.dayanPrediction.data)
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
    }
    
    func DayanPrediction() {
        modelData.dayanPrediction.Execute()
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func DayanParser() {
        let hexagrams = modelData.derivedHexagrams
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
