//
//  HexagramPerDayView.swift
//  Change
//
//  Created by aiqin139 on 2021/3/10.
//

import SwiftUI

struct RecordView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ScrollView {
            ForEach(modelData.hexagramRecord.reversed(), id: \.self) { record in
                Spacer()
                RecordCard(recordData: record)
                Spacer()
            }
        }
        .navigationTitle("占卦记录")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
            .environmentObject(ModelData())
    }
}
