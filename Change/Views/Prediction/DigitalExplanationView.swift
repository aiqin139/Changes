//
//  DigitalExplanationView.swift
//  Change
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct DigitalExplanationView: View {
    var digitalData: DigitalData

    var body: some View {
        VStack {
            Text("数字卦")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .frame(width: 350)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                .padding(.vertical, 15.0)
            
            VStack {
                Text(digitalData.pinyin)
                    .font(.title)
                Text(digitalData.name)
                    .font(.title)
            
                Image(digitalData.name)
                    .resizable()
                    .frame(width: 200, height: 200)
                
                HStack {
                    ForEach(digitalData.result, id: \.self) { content in
                        Text(String(content))
                            .font(.title)
                            .padding(.horizontal)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                    }
                }
            }
            .frame(width: 350, height: 350)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
            .padding(.vertical, -5.0)
            
            VStack(alignment: .leading) {
                ForEach(digitalData.explanation, id: \.self) { content in
                    Text(content)
                        .font(.title3)
                        .padding(.horizontal, 10.0)
                        .minimumScaleFactor(0.1)
                }
            }
            .frame(width: 350)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
            .padding(.vertical, 15.0)
        }
        .frame(width: 370)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
    }
}

struct DigitalExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        DigitalExplanationView(digitalData: DigitalData(
            name: ModelData().derivedHexagrams[0].name,
            pinyin: ModelData().derivedHexagrams[0].pinyin,
            explanation: ModelData().derivedHexagrams[0].explanations[0]
        ))
    }
}
