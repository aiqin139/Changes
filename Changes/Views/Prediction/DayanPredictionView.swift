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
    
    enum PageType: Int {
        case predictingView, parserView, questionView
    }
    
    struct PredictingData {
        var partA: Int = 0
        var partB: Int = 0
        var modA: [Int] = [Int](repeating: 0, count: 3)
        var modB: [Int] = [Int](repeating: 0, count: 3)
        var head: [Int] = [Int](repeating: 0, count: 3)
        var count: [Int] = [Int](repeating: 0, count: 3)
        var remains: [Int] = [Int](repeating: 0, count: 18)
        var result: [Int] = [Int](repeating: 0, count: 6)
    }
    
    @State private var isPredicting = false
    @State private var predictingTask: Task<Void, Error>?
    @State private var popPages: [PageType] = []
    @State private var dydat = PredictingData()
    @State private var opcity: Double = 1
    
    private var yao: [String] = ["初", "二", "三", "四", "五", "上"]
    private var accentColor: Color { return (colorScheme == .dark) ? .white : .black }

    var body: some View {
        ZStack {
            PredictionView()

            switch popPages.last {
                case .predictingView: PredictingView()
                case .parserView: ParserView()
                case .questionView: QuestionView()
                case .none: EmptyView()
            }
        }
        .navigationTitle("大衍卦")
        .navigationBarItems(trailing: Button(action: {
            popPages.append(PageType.questionView)
        }) {
                Image(systemName: "questionmark.circle")
                    .foregroundColor(accentColor)
        })
        .onDisappear() { self.CancelPredictionTask() }
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
                    Text((index == 0 || index == 5) ? (yao[index] + name) : (name + yao[index]))
       
                    NumberPicker(start: 6, end: 9, value: $modelData.dayanPrediction.data.result[index])
                        .font(.title)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(accentColor, lineWidth: 2))
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
                    .overlay(HexagramShape().stroke(accentColor, lineWidth: 2))
                    .foregroundColor(accentColor)
            }
            .opacity(self.opcity)
            .onTapGesture { opcity = 0.8 }
            .onLongPressGesture { function() }
        }
    }
    
    func ButtonView(_ width: CGFloat) -> some View {
        HStack {
            Spacer()
            LongPressButton(width, "占", self.DayanPredictionTask)
            Spacer()
            LongPressButton(width, "解", self.DayanParser)
            Spacer()
        }
        .frame(width: width)
    }
    
    func ParserView() -> some View {
        VStack(spacing: 0) {
            ScrollView(.vertical, showsIndicators: false) {
                DayanExplanationView(dayanData: modelData.dayanPrediction.data)
            }
            Divider()
            Text("点击任意位置返回").padding(.top)
        }
        .onTapGesture { popPages.removeLast() }
    }
    
    func QuestionView() -> some View {
        VStack {
            RTFReader(fileName: "大衍占法")
            
            Text("点击任意位置返回")
        }
        .onTapGesture { popPages.removeLast() }
    }
    
    func PredictionView() -> some View {
        GeometryReader { geometry in
            let imageWidth = geometry.size.width * 0.8
            let imageHeight = geometry.size.height * 0.5
            let width = (imageHeight > geometry.size.width) ? imageWidth : imageHeight
            
            VStack {
                Spacer()
                ImageView(width)
                Spacer()
                PickerView(width)
                Spacer()
                ButtonView(width)
                Spacer()
            }
            .blur(radius: (popPages.count != 0) ? 10 : 0)
            .disabled((popPages.count != 0) ? true : false)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// MARK: DayanPredictionView predicting views

extension DayanPredictionView {
    func PredictingView() -> some View {
        VStack {
            VStack {
                Text("★")
                    .frame(maxWidth: .infinity, minHeight: 30)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(accentColor, lineWidth: 2))
                
                HStack() {
                    HStack {
                        ForEach(0..<3, id: \.self) { i in
                            VStack {
                                Text(String(dydat.count[i]))
                                Text(" ")
                                Text((dydat.head[i] == 1) ? "★" : " ")
                                Text(" ")
                                ForEach(0..<4, id: \.self) { j in
                                    Text((j < dydat.modA[i]) ? "★" : " ")
                                }
                                Text(" ")
                                ForEach(0..<4, id: \.self) { j in
                                    Text((j < dydat.modB[i]) ? "★" : " ")
                                }
                                Text(" ")
                            }
                            .frame(minWidth: 20)
                        }
                    }
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(accentColor, lineWidth: 2))
                    
                    VStack {
                        Text(String(dydat.partA))
                        Spacer()
                        ForEach(0..<12) { i in
                            HStack {
                                ForEach(0..<4, id: \.self) { j in
                                    if ((i * 4 + j) < dydat.partA) {
                                        Text("★")
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(accentColor, lineWidth: 2))
                    
                    VStack {
                        Text(String(dydat.partB))
                        Spacer()
                        ForEach(0..<12) { i in
                            HStack {
                                ForEach(0..<4, id: \.self) { j in
                                    if ((i * 4 + j) < dydat.partB) {
                                        Text("★")
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(accentColor, lineWidth: 2))
                }
            }
            .font(.system(size: 18))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack {
                ForEach(0..<6, id: \.self) { i in
                    VStack {
                        Text(yao[i])
                        
                        VStack {
                            ForEach(0..<3, id: \.self) { j in
                                Text(String(dydat.remains[(i * 3) + j]))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(accentColor, lineWidth: 2))
                        
                        Text(dydat.result[i] != 0 ? (((dydat.result[i] % 2) == 0) ? "六" : "九"): " ")
                        
                        Text(String(dydat.result[i]))
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(accentColor, lineWidth: 2))
                    }
                }
            }
            .font(.system(size: 18))
            
            Divider()
            
            VStack(alignment: .center) {
                Text("注意：占卦完成之后")
                Text("点击任意位置返回；长按任意位置解卦。")
                Text("大衍卦占卦值会更新为此次占卦的结果。")
                Text("在大衍卦界面，长按<解>也可以解卦。")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture { if self.isPredicting == false { self.popPages.removeLast() } }
        .onLongPressGesture { if self.isPredicting == false { self.DayanParser() } }
        .padding()
    }
}

// MARK: DayanPredictionView methods

extension DayanPredictionView {
    func Notifiy() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func DayanPredictionTask() {
        predictingTask = Task {
            isPredicting = true
            dydat.remains = [Int](repeating: 0, count: 18)
            dydat.result = [Int](repeating: 0, count: 6)

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

                dydat.result[part] = modelData.dayanPrediction.data.result[part]
            }

            isPredicting = false
        }
        
        popPages.append(.predictingView)
    }
    
    func CancelPredictionTask() {
        if let t = predictingTask {
            t.cancel()
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
        
        popPages.append(.parserView)
        
        Notifiy()
    }
}

// MARK: Swiftui Preview

struct DayanPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        DayanPredictionView()
            .environmentObject(ModelData())
        DayanPredictionView().PredictingView()
            .environmentObject(ModelData())
    }
}
