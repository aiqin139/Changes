//
//  RecordView.swift
//  Changes
//
//  Created by aiqin139 on 2021/3/10.
//

import SwiftUI

struct RecordView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ScrollView(.vertical) {
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
    static var modelData: ModelData = {
        let modelData = ModelData()
        
        modelData.digitalPrediction.data = DigitalData(
            name: ModelData().derivedHexagrams[0].name,
            pinyin: ModelData().derivedHexagrams[0].pinyin,
            explanation: ModelData().derivedHexagrams[0].explanations[0]
        )
        
        let recordData = RecordData(type: RecordType.Digital.rawValue, digit: modelData.digitalPrediction.data, date: Date())
        
        modelData.hexagramRecord = [recordData, recordData, recordData]
        
        return modelData
    }()
    
    static var previews: some View {
        RecordView()
            .environmentObject(modelData)
    }
}
