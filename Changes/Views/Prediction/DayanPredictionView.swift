//
//  DayanPredictionView.swift
//  Changes
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

// MARK: DayanPredictionView

struct DayanPredictionView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.colorScheme) var colorScheme
    @State private var isParser = false
    @State private var isQuestion = false
    @State private var opcity: Double = 1
    private var yao: [String] = ["初", "二", "三", "四", "五", "上"]
    
    var accentColor: Color {
        return (colorScheme == .dark) ? .white : .black
    }
        
    var body: some View {
        GeometryReader { geometry in
            let imageWidth = geometry.size.width * 0.8
            let imageHeight = geometry.size.height * 0.5
            let width = (imageHeight > geometry.size.width) ? imageWidth : imageHeight
            
            ZStack {
                VStack {
                    Spacer()
                    ImageView(width)
                    Spacer()
                    PickerView(width)
                    Spacer()
                    ButtonView(width)
                    Spacer()
                }
                .blur(radius: (isParser || isQuestion) ? 10 : 0)
                .disabled((isParser || isQuestion) ? true : false)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                if $isParser.wrappedValue { ParserView() }
                if $isQuestion.wrappedValue { QuestionView() }
            }
            .shadow(radius: 100)
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
}

// MARK: DayanPredictionView views

extension DayanPredictionView {
    func ImageView(_ width: CGFloat) -> some View {
        RotateEightTrigrams(lineWidth: 2, lineColor: accentColor)
            .frame(width: width * 0.9, height: width * 0.9, alignment: .center)
    }
    
    func PickerView(_ width: CGFloat) -> some View {
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
        .frame(width: width)
    }
    
    func ButtonView(_ width: CGFloat) -> some View {
        HStack {
            Spacer()
            
            Button(action: {}) {
                VStack {
                    Text("占")
                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                        .frame(width: width * 0.2, height: width * 0.2)
                        .overlay(HexagramShape().stroke(self.accentColor, lineWidth: 2))
                        .foregroundColor(self.accentColor)
                }
                .opacity(self.opcity)
                .onTapGesture { opcity = 0.8 }
                .onLongPressGesture { DayanPrediction() }
            }
            
            Spacer()
            
            Button(action: {}) {
                VStack {
                    Text("解")
                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                        .frame(width: width * 0.2, height: width * 0.2)
                        .overlay(HexagramShape().stroke(self.accentColor, lineWidth: 2))
                        .foregroundColor(self.accentColor)
                }
                .opacity(self.opcity)
                .onTapGesture { opcity = 0.8 }
                .onLongPressGesture { DayanParser() }
            }
            
            Spacer()
        }
        .frame(width: width)
    }
        
    func ParserView() -> some View {
        VStack {
            DayanExplanationView(dayanData: modelData.dayanPrediction.data)
                .cornerRadius(10).shadow(radius: 20)

            Button(action: {
                self.isParser = false
            }) {
                Image(systemName: "xmark.seal")
                    .resizable()
                    .foregroundColor(accentColor)
                    .frame(width: 50, height: 50)
            }
        }
        .padding(.bottom, 15.0)
    }
    
    func QuestionView() -> some View {
        VStack {
            RTFReader(fileName: "大衍占法")
            
            Button(action: {
                self.isQuestion = false
            }) {
                Image(systemName: "xmark.seal")
                    .resizable()
                    .foregroundColor(accentColor)
                    .frame(width: 50, height: 50)
            }
        }
        .padding(.bottom, 15.0)
    }
}

// MARK: DayanPredictionView methods

extension DayanPredictionView {
    func Notifiy() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func DayanPrediction() {
        modelData.dayanPrediction.Execute()
        Notifiy()
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
        
        self.isParser = true
        
        Notifiy()
    }
}

// MARK: Swiftui Preview

struct DayanPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        DayanPredictionView()
            .environmentObject(ModelData())
    }
}
