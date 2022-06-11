//
//  DayanPredictionView.swift
//  Changes
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

// MARK: DayanPredictingData

struct DayanPredictingData {
    var partA: Int = 0
    var partB: Int = 0
    var modA: [Int] = [Int](repeating: 0, count: 3)
    var modB: [Int] = [Int](repeating: 0, count: 3)
    var head: [Int] = [Int](repeating: 0, count: 3)
    var count: [Int] = [Int](repeating: 0, count: 3)
    var remains: [Int] = [Int](repeating: 0, count: 18)
}

// MARK: DayanPredictionView

struct DayanPredictionView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.colorScheme) var colorScheme
    @State private var isStart = false
    @State private var isParser = false
    @State private var isQuestion = false
    @State private var opcity: Double = 1
    @State private var dydat = DayanPredictingData()
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
    
    func ButtonWithFunc(_ width: CGFloat, _ text: String, _ function : @escaping () -> Void ) -> some View{
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
            ButtonWithFunc(width, "占", self.DayanPredictionTask)
            Spacer()
            ButtonWithFunc(width, "解", self.DayanParser)
            Spacer()
        }
        .frame(width: width)
    }
    
    func CancelButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: "xmark.seal")
                .resizable()
                .foregroundColor(accentColor)
                .frame(width: 50, height: 50)
        }
    }
    
    func ParserView() -> some View {
        VStack {
            DayanExplanationView(dayanData: modelData.dayanPrediction.data)
                .cornerRadius(10).shadow(radius: 20)

            CancelButton(action: { self.isParser = false } )
        }
        .padding(.bottom, 15.0)
    }
    
    func QuestionView() -> some View {
        VStack {
            RTFReader(fileName: "大衍占法")
            
            CancelButton(action: { self.isQuestion = false } )
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
                            Text(String(dydat.count[i])).foregroundColor(.red)
                            Text((dydat.head[i] == 1) ? "★" : " ")
                            Text(" ")
                            ForEach(0..<4, id: \.self) { j in
                                Text((j < dydat.modA[i]) ? "★" : " ")
                            }
                            Text(" ")
                            ForEach(0..<4, id: \.self) { j in
                                Text((j < dydat.modB[i]) ? "★" : " ")
                            }
                        }
                    }
                }
                
                Divider()
                
                VStack {
                    Text(String(dydat.partA)).foregroundColor(.red)
                    VStack(alignment: .leading) {
                        ForEach(0..<6, id: \.self) { i in
                            HStack {
                                ForEach(0..<8, id: \.self) { j in
                                    if j == 4 { Text(" ") }
                                    Text(((i * 8 + j) < dydat.partA) ? "★" : " ")
                                }
                            }
                        }
                    }
                    
                    Divider()
                    
                    Text(String(dydat.partB)).foregroundColor(.red)
                    VStack(alignment: .leading) {
                        ForEach(0..<6, id: \.self) { i in
                            HStack {
                                ForEach(0..<8, id: \.self) { j in
                                    if j == 4 { Text(" ") }
                                    Text(((i * 8 + j) < dydat.partB) ? "★" : " ")
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
                            Text(String(dydat.remains[(i * 3) + j]))
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
            self.isStart = true
            dydat.remains = [Int](repeating: 0, count: 18)
            
            for part in 0..<6 {
                dydat.count = [Int](repeating: 0, count: 3)
                dydat.head = [Int](repeating: 0, count: 3)
                dydat.modA = [Int](repeating: 0, count: 3)
                dydat.modB = [Int](repeating: 0, count: 3)
                
                var remain = 50 - 1
                for step in 0..<3 {
                    Notifiy()
                    dydat.partA = 0
                    dydat.partB = 0
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    let res = modelData.dayanPrediction.Execute(part, step, remain)
                    dydat.partA = res.partA + 1
                    dydat.partB = res.partB
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    dydat.head[step] = 1
                    dydat.count[step] = 1
                    dydat.partA = res.partA
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    dydat.modA[step] = res.modA
                    dydat.partA = res.partA - res.modA
                    dydat.count[step] += res.modA
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    dydat.modB[step] = res.modB
                    dydat.partB = res.partB - res.modB
                    dydat.count[step] += res.modB
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    remain = res.remain
                    dydat.remains[(part * 3) + step] = remain
                    try await Task.sleep(nanoseconds: 1_000_000_000)
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
