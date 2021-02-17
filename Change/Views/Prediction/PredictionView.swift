//
//  PredictionView.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct PredictionView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            VStack {
                Image("先天八卦图")
                     .resizable()
                     .frame(width: 350, height: 350)
                
                List {
                    NavigationLink(destination: DigitalPredictionView().environmentObject(modelData)) {
                        Text("数字卦（占小事）")
                            .navigationTitle("数字卦")
                    }
                    
                    NavigationLink(destination: DayanPredictionView().environmentObject(modelData)) {
                        Text("大衍卦（占大事）")
                            .navigationTitle("大衍卦")
                    }
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
