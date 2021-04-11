//
//  RecordCard.swift
//  Change
//
//  Created by aiqin139 on 2021/4/11.
//

import SwiftUI

struct RecordCard: View {
    var recordData: RecordData
    
    private func Dateformat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-yy HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            VStack {
                if (RecordType.Digital.rawValue == recordData.type) {
                    DigitalExplanationView(digitalData: recordData.digit)
                }
                else if (RecordType.Dayan.rawValue == recordData.type) {
                    DayanExplanationView(dayanData: recordData.dayan)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))
            
            Text(Dateformat(date: recordData.date))
                .font(.title2)
        }
    }
}

struct RecordCard_Previews: PreviewProvider {
    static var previews: some View {
        RecordCard(recordData: RecordData(
            type: RecordType.Digital.rawValue, digit: DigitalData(
                hexagram: ModelData().derivedHexagrams[0],
                explanation: ModelData().derivedHexagrams[0].explanations[0]
            ), date: Date()
        ))
        RecordCard(recordData: RecordData(
            type: RecordType.Dayan.rawValue, dayan: DayanData(
                benHexagram: ModelData().derivedHexagrams[0],
                zhiHexagram: ModelData().derivedHexagrams[1],
                explanation1: ModelData().derivedHexagrams[0].explanations[0],
                explanation2: ModelData().derivedHexagrams[1].explanations[1]
            ), date: Date()
        ))
    }
}
