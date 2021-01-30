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
            Image("先天八卦图")
                .resizable()
                .frame(width: 400, height: 400)
        }
    }
}

struct PredictionView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionView()
    }
}
