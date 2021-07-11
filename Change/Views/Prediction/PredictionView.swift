//
//  PredictionView.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct PredictionView: View {
    private var uiWidth = UIScreen.main.nativeBounds.width
    private var uiHeight = UIScreen.main.nativeBounds.height
    @EnvironmentObject var modelData: ModelData
    @Environment(\.colorScheme) var colorScheme
    
    var accentColor: Color {
        return (colorScheme == .dark) ? .white : .black
    }
    
    var body: some View {
        NavigationView {
            VStack {
                RotateImage(image: "先天八卦图")
                    .frame(width: uiWidth * 0.3, height: uiWidth * 0.3)
   
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


struct PredictionView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionView()
            .environmentObject(ModelData())
    }
}
