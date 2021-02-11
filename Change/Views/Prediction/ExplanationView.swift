//
//  ExplanationView.swift
//  Change
//
//  Created by aiqin139 on 2021/1/30.
//

import SwiftUI

struct ExplanationView: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        PageView(pages: [ExplanationViews(digital: 1), ExplanationViews(digital: 0)])
            .aspectRatio(1, contentMode: .fill)
            .environmentObject(modelData)
    }
}

struct ExplanationViews: View {
    @EnvironmentObject var modelData: ModelData
    var digital = 1
    
    var body: some View {
        VStack {
            if digital == 1 {
                DigitalExplanationView()
                    .environmentObject(modelData)
            }
            else {
                DayanExplanationView()
                    .environmentObject(modelData)
            }
        }
    }
}

struct ExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        ExplanationView()
            .environmentObject(ModelData())
    }
}
