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
    
    enum PageType: Int {
        case parserView, questionView
    }
    
    @State private var isPredicting = false
    @State private var popPages: [PageType] = []
    @State private var opcity: Double = 1
    
    private var accentColor: Color { return (colorScheme == .dark) ? .white : .black }
    
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
                .blur(radius: (popPages.count != 0) ? 20 : 0)
                .disabled((popPages.count != 0) ? true : false)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                switch popPages.last {
                    case .parserView: ParserView()
                    case .questionView: QuestionView()
                    case .none: EmptyView()
                }
            }
            .navigationTitle("数字卦")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                popPages.append(PageType.questionView)
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
        RotateEightTrigrams(lineWidth: 2, lineColor: accentColor)
            .frame(width: width * 0.9, height: width * 0.9, alignment: .center)
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
    
    func LongPressButton(_ width: CGFloat, _ text: String, _ function : @escaping () -> Void ) -> some View{
        Button(action: {}) {
            VStack {
                Text(text)
                    .font(.system(size: 40, weight: .semibold, design: .rounded))
                    .frame(width: width * 0.2, height: width * 0.2)
                    .overlay(HexagramShape().stroke(self.accentColor, lineWidth: 2))
                    .foregroundColor(self.accentColor)
            }
            .opacity(self.opcity)
            .onTapGesture { opcity = 0.8 }
            .onLongPressGesture { function() }
        }
    }
    
    func ButtonView(_ width: CGFloat) -> some View {
        HStack {
            Spacer()
            LongPressButton(width, "占", self.DigitPredictionTask)
            Spacer()
            LongPressButton(width, "解", self.DigitParser)
            Spacer()
        }
        .frame(width: width)
    }
        
    func ParserView() -> some View {
        VStack {
            DigitalExplanationView(digitalData: modelData.digitalPrediction.data)
                .cornerRadius(10).shadow(radius: 20)

            Text("点击任意位置返回")
        }
        .onTapGesture { popPages.removeLast() }
    }
    
    func QuestionView() -> some View {
        VStack {
            RTFReader(fileName: "数字占法")
            
            Text("点击任意位置返回")
        }
        .onTapGesture { popPages.removeLast() }
    }
}

// MARK: DigitialPredictionView methods

extension DigitalPredictionView {
    func Notifiy() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func DigitPredictionTask() {
        Task {
            self.isPredicting = true
            for _ in 1..<50 {
                self.DigitPrediction()
                try await Task.sleep(nanoseconds: 50_000_000)
            }
            self.isPredicting = false
        }
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
        
        popPages.append(.parserView)
        
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
