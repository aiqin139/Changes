//
//  DigitalPredictionView.swift
//  Changes
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

// MARK: DigitialPredictionView

struct DigitalPredictionView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.colorScheme) var colorScheme
    @State private var isParser = false
    @State private var isQuestion = false
    @State private var opcity: Double = 1
    
    var accentColor: Color {
        return (colorScheme == .dark) ? .white : .black
    }
    
    var body: some View {
        GeometryReader { geometry in
            let imageWidth = geometry.size.width * 0.8
            let imageHeight = geometry.size.height * 0.45
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
            .shadow(radius: 20)
            .navigationTitle("数字卦")
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

// MARK: DigtialPredictionView views

extension DigitalPredictionView {
    func ImageView(_ width: CGFloat) -> some View {
        RotateImage(image: "先天八卦图", lineWidth: 2)
            .frame(width: width * 0.8, height: width * 0.8, alignment: .center)
    }
    
    func PickerView(_ width: CGFloat) -> some View {
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
        .frame(width: width)
    }
    
    func ButtonView(_ width: CGFloat) -> some View {
        HStack{
            Spacer()
            
            Button(action: {}) {
                VStack {
                    Image("占")
                        .resizable()
                        .frame(width: width * 0.2, height: width * 0.2)
                        .clipShape(HexagramShape())
                        .overlay(HexagramShape().stroke(self.accentColor, lineWidth: 2))
                }
                .opacity(self.opcity)
                .onTapGesture { self.opcity = 0.8 }
                .onLongPressGesture { self.DigitPrediction() }
            }
            
            Spacer()
            
            Button(action: {}) {
                VStack {
                    Image("解")
                        .resizable()
                        .frame(width: width * 0.2, height: width * 0.2)
                        .clipShape(HexagramShape())
                        .overlay(HexagramShape().stroke(self.accentColor, lineWidth: 2))
                }
                .opacity(self.opcity)
                .onTapGesture { self.opcity = 0.8 }
                .onLongPressGesture { self.DigitParser() }
            }

            Spacer()
        }
        .frame(width: width)
    }
        
    func ParserView() -> some View {
        VStack {
            DigitalExplanationView(digitalData: modelData.digitalPrediction.data)
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
            RTFReader(fileName: "数字占法")
            
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

// MARK: DigitialPredictionView methods

extension DigitalPredictionView {
    func Notifiy() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func DigitPrediction() {
        modelData.digitalPrediction.Execute()
        Notifiy()
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
        
        self.isParser = true
        
        Notifiy()
    }
}

// MARK: Swiftui Preview

struct DigitalPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        DigitalPredictionView()
            .environmentObject(ModelData())
    }
}
