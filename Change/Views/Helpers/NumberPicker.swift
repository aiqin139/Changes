//
//  NumberPicker.swift
//  Change
//
//  Created by aiqin139 on 2021/2/18.
//

import SwiftUI

struct NumberPicker: View {
    var label: String = ""
    var format: String = "%d"
    var start: Int = 0
    var end: Int = 9
    @Binding var value: Int
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                if label != "" {
                    Text(label)
                }
                
                Picker("Number", selection: $value) {
                    ForEach(start...end, id: \.self) { number in
                        Text(String(format: format, number))
                            .tag(number)
                    }
                }
                .frame(maxWidth: geometry.size.width / (label == "" ? 1 : 2))
                .clipped()
            }
            .shadow(color: .black, radius: 10)
        }
    }
}

struct NumberPicker_Previews: PreviewProvider {
    @State static private var value1: Int = 0
    @State static private var value2: Int = 1
    @State static private var value3: Int = 2
    
    static var previews: some View {
        HStack {
            NumberPicker(label: "数字1:", format: "%03d", start: 0, end: 999, value: $value1)
            NumberPicker(label: "数字2:", format: "%03d", start: 0, end: 999, value: $value2)
            NumberPicker(label: "数字3:", format: "%03d", start: 0, end: 999, value: $value3)
        }
    }
}
