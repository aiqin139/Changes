//
//  PredictionView.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct PredictionView: View {
    var body: some View {
        VStack {
            CircleImage(image: Image("乾卦"))
                .offset(y: 0)
                .padding(.bottom, 0)
        }
    }
}

struct PredictionView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionView()
    }
}
