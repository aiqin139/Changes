//
//  PredictionView.swift
//  Changes
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct PredictionNavigationView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        GeometryReader { geometry in
            let imageWidth = geometry.size.height * 0.5
            let imageHeight = geometry.size.height * 0.5
            
            VStack {
                RotateImage(image: "先天八卦图")
                    .frame(width: imageWidth, height: imageHeight)

                Form {
                    VStack(alignment: .center) {
                        Text("所占何事").bold()
                        
                        Picker("Purpose", selection: $modelData.fortuneTellingPurpose) {
                            ForEach(Purposes.allCases) { purpose in
                                Text(purpose.rawValue).tag(purpose)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    NavigationLink(destination: DigitalPredictionView().environmentObject(modelData),
                                   isActive: $modelData.isDigitalPresented){
                        Text("数字卦（占小事）")
                    }

                    NavigationLink(destination: DayanPredictionView().environmentObject(modelData),
                                   isActive: $modelData.isDayanPresented){
                        Text("大衍卦（占大事）")
                    }
                }
            }
        }
        .navigationTitle("占卦")
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
