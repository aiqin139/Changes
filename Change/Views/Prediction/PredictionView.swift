//
//  PredictionView.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct PredictionNavigationView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.colorScheme) var colorScheme
    
    var accentColor: Color {
        return (colorScheme == .dark) ? .white : .black
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                RotateImage(image: "先天八卦图")
                    .frame(width: geometry.size.height * 0.45, height: geometry.size.height * 0.45)

                Form {
                    Button(action: { modelData.isDigitalPresented = true }) {
                            Text("数字卦（占小事）")
                    }.sheet(isPresented: $modelData.isDigitalPresented, content: {
                        DigitalPredictionView()
                            .environmentObject(modelData)
                            .animation(.easeInOut(duration: 0.3))
                    })
                    .frame(height: 30)
                    .accentColor(accentColor)
                    
                    Button(action: { modelData.isDayanPresented = true }) {
                            Text("大衍卦（占大事）")
                    }.sheet(isPresented: $modelData.isDayanPresented, content: {
                        DayanPredictionView()
                            .environmentObject(modelData)
                            .animation(.easeInOut(duration: 0.3))
                    })
                    .frame(height: 30)
                    .accentColor(accentColor)
                }
            }
            .navigationTitle("占卦")
        }
    }
}

struct PredictionView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            PredictionNavigationView()
                .environmentObject(modelData)
        }
    }
}

struct PredictionView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionView()
            .environmentObject(ModelData())
    }
}
