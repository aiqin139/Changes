//
//  RecordView.swift
//  Change
//
//  Created by aiqin139 on 2021/3/10.
//

import SwiftUI

struct RecordView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                ForEach(modelData.hexagramRecord.reversed(), id: \.self) { record in
                    RecordCard(recordData: record)
                }
            }
        }
        .navigationBarItems(trailing:
            Button(action: {
            clearRecord()
            modelData.hexagramRecord = loadRecord()
        }) {
            Text("清除")
        })
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
