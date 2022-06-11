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
    @State private var isStart = false
    @State private var isParser = false
    @State private var isQuestion = false
    @State private var opcity: Double = 1
    private var yao: [String] = ["初", "二", "三", "四", "五", "上"]
    @State var remains: [Int] = [0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0]
    @State var a: Int = 0
    @State var b: Int = 0
    @State var d: [Int] = [0,0,0]
    @State var h: [Int] = [0,0,0]
    @State var a1: [Int] = [0,0,0]
    @State var b1: [Int] = [0,0,0]
    
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
                .blur(radius: (isParser || isQuestion || isStart) ? 10 : 0)
                .disabled((isParser || isQuestion || isStart) ? true : false)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                if $isParser.wrappedValue { ParserView() }
                if $isQuestion.wrappedValue { QuestionView() }
                if $isStart.wrappedValue { PredictingView() }
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
                .onLongPressGesture { self.DayanPredictionTask() }
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
    
    func PredictingView() -> some View {
        VStack {
            Divider()
            
            Text("★")
            
            Divider()
            
            HStack {
                Divider()
                
                HStack {
                    ForEach(0..<3, id: \.self) { i in
                        VStack {
                            Text(String(d[i])).foregroundColor(.red)
                            Text((h[i] == 1) ? "★" : " ")
                            Text(" ")
                            ForEach(0..<4, id: \.self) { j in
                                Text((j < a1[i]) ? "★" : " ")
                            }
                            Text(" ")
                            ForEach(0..<4, id: \.self) { j in
                                Text((j < b1[i]) ? "★" : " ")
                            }
                        }
                    }
                }
                
                Divider()
                
                VStack {
                    Text(String(a)).foregroundColor(.red)
                    VStack(alignment: .leading) {
                        ForEach(0..<6, id: \.self) { i in
                            HStack {
                                ForEach(0..<8, id: \.self) { j in
                                    if j == 4 { Text(" ") }
                                    Text(((i * 8 + j) < a) ? "★" : " ")
                                }
                            }
                        }
                    }
                    
                    Divider()
                    
                    Text(String(b)).foregroundColor(.red)
                    VStack(alignment: .leading) {
                        ForEach(0..<6, id: \.self) { i in
                            HStack {
                                ForEach(0..<8, id: \.self) { j in
                                    if j == 4 { Text(" ") }
                                    Text(((i * 8 + j) < b) ? "★" : " ")
                                }
                            }
                        }
                    }
                }
                
                Divider()
            }
            
            Divider()
            
            HStack {
                ForEach(0..<6, id: \.self) { i in
                    VStack {
                        ForEach(0..<3, id: \.self) { j in
                            Text(String(remains[(i * 3) + j]))
                        }
                    }
                    .font(.title)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(accentColor, lineWidth: 2))
                }
            }
            
            Divider()
        }
        .frame(height: 400)
    }
}

// MARK: DayanPredictionView methods

extension DayanPredictionView {
    func Notifiy() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func DayanPredictionTask() {
        Task {
            for i in 0..<18  {
                self.remains[i] = 0
            }
            
            self.isStart = true
            for part in 0..<6 {
                
                for i in 0..<3 {
                    self.h[i] = 0
                    self.a1[i] = 0
                    self.b1[i] = 0
                    self.d[i] = 0
                }
                
                var remain = 50 - 1
                for step in 0..<3 {
                    Notifiy()
                    self.a = 0
                    self.b = 0
                    let res = modelData.dayanPrediction.Execute(part, step, remain)
                    try await Task.sleep(nanoseconds: 1000_000_000)
                    a = res[0] + 1
                    b = res[1]
                    try await Task.sleep(nanoseconds: 1000_000_000)
                    h[step] = 1
                    d[step] = h[step]
                    a = res[0]
                    try await Task.sleep(nanoseconds: 1000_000_000)
                    a = res[0] - res[2]
                    a1[step] = res[2]
                    d[step] = d[step] + a1[step]
                    try await Task.sleep(nanoseconds: 1000_000_000)
                    b = res[1] - res[3]
                    b1[step] = res[3]
                    d[step] = d[step] + b1[step]
                    try await Task.sleep(nanoseconds: 1000_000_000)
                    remain = res[4]
                    self.remains[(part * 3) + step] = remain
                    try await Task.sleep(nanoseconds: 1000_000_000)
                }
            }
            self.isStart = false
        }
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
