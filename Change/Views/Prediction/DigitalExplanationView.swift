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
            Spacer()
            
            Text("数字卦")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            Text(digitalData.pinyin)
                .font(.title)
                .foregroundColor(.primary)
            Text(digitalData.name)
                .font(.title)
                .foregroundColor(.primary)
        
            Image(digitalData.name)
                .resizable()
                .frame(width: 250, height: 250)
            
            HStack {
                ForEach(digitalData.result, id: \.self) { content in
                    Text(String(content))
                        .font(.title)
                        .padding(.horizontal)
                        .border(Color(UIColor.separator))
                        .contentShape(Rectangle())
                        .frame(width: 50, height: 50)
                        .animation(.easeInOut(duration: 1.0))
                        .shadow(radius: 15)
                }
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                ForEach(digitalData.explanation, id: \.self) { content in
                    Text(content)
                        .font(.title3)
                        .padding(.horizontal, 10.0)
                        .minimumScaleFactor(0.1)
                }
            }
            
            Spacer()
        }
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
