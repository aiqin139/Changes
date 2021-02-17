//
//  PredictionView.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct PredictionView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var isDigitalPresented = false
    @State private var isDayanPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("先天八卦图")
                     .resizable()
                     .frame(width: 350, height: 350)
                
                List {
                    Button(action: { isDigitalPresented = true }) {
                            Text("数字卦（占小事）")
                    }.sheet(isPresented: $isDigitalPresented, content: {
                        DigitalPredictionView().environmentObject(modelData)
                    })
                    .frame(height: 30)
                    
                    Button(action: { isDayanPresented = true }) {
                            Text("大衍卦（占大事）")
                    }.sheet(isPresented: $isDayanPresented, content: {
                        DayanPredictionView().environmentObject(modelData)
                    })
                    .frame(height: 30)
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
