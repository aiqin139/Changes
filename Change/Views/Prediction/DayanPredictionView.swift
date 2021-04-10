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
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("大衍卦")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            RotateImage(image: "先天八卦图")
                .frame(width: 350, height: 350)
            
            Spacer()
            
            HStack {
                ForEach(0...5, id: \.self) { index in
                    NumberPicker(start: 6, end: 9, value: $modelData.dayanPrediction.result[index])
                        .font(.title)
                        .border(Color(UIColor.separator))
                        .contentShape(Rectangle())
                        .shadow(radius: 15)
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {}) {
                    VStack {
                        Image("占")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                    }
                    .opacity(self.opcity)
                    .onTapGesture { opcity = 0.8 }
                    .onLongPressGesture { DayanPrediction() }
                    .shadow(radius: 5)
                }
                
                Spacer()
                
                Button(action: {}) {
                    VStack {
                        Image("解")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                    }
                    .opacity(self.opcity)
                    .onTapGesture { opcity = 0.8 }
                    .onLongPressGesture { DayanParser() }
                    .shadow(radius: 5)
                }
                .sheet(isPresented: $isPresented, content: {
                     DayanExplanationView(dayanPrediction: modelData.dayanPrediction)
                 })
                
                Spacer()
            }
        }
        .navigationTitle("大衍卦")
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
