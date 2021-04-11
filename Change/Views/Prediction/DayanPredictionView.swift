//
//  DayanPredictionView.swift
//  Change
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DayanPredictionView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var isPresented = false
    @State private var opcity: Double = 1
    private var yao: [String] = ["初", "二", "三", "四", "五", "上"]
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("大衍卦")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            RotateImage(image: "先天八卦图", lineWidth: 2)
                .frame(width: 350, height: 350)
            
            Spacer()
            
            HStack {
                ForEach(0...5, id: \.self) { index in
                    VStack {
                        let name = (((modelData.dayanPrediction.result[index] % 2) == 0) ? "六" : "九")
                        if (index == 0 || index == 5) {
                            Text(yao[index] + name)
                        }
                        else {
                            Text(name + yao[index])
                        }
                        NumberPicker(start: 6, end: 9, value: $modelData.dayanPrediction.result[index])
                            .font(.title)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                    }
                }
            }
            
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
                    .onLongPressGesture { DayanPrediction() }
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
                    .onLongPressGesture { DayanParser() }
                }
                .sheet(isPresented: $isPresented, content: {
                     DayanExplanationView(dayanPrediction: modelData.dayanPrediction)
                 })
                
                Spacer()
            }
        }
        .shadow(radius: 20)
    }
    
    func DayanPrediction() {
        modelData.dayanPrediction.Execute()
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func DayanParser() {
        let hexagrams = modelData.derivedHexagrams
        modelData.dayanPrediction.Parser(hexagrams: hexagrams)
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        self.isPresented = true
    }
}

struct DayanPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        DayanPredictionView()
            .environmentObject(ModelData())
    }
}
