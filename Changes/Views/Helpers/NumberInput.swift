//
//  NumberInput.swift
//  Changes
//
//  Created by aiqin139 on 2021/2/1.
//

import SwiftUI

struct NumberInput: View {
    var labelText: String = "number:"
    @Binding var value: String

    func EndEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        HStack {
            Label(labelText, systemImage: "bolt.fill")
                .labelStyle(TitleOnlyLabelStyle())
                .font(.title2)
                
            TextField("000", text: $value)
                .font(.title2)
                .keyboardType(UIKeyboardType.numbersAndPunctuation)
                .border(Color(UIColor.separator))
                .contentShape(Rectangle())
                .onTapGesture { }
                .onLongPressGesture(
                    pressing: { isPressed in if isPressed { self.EndEditing() } },
                    perform: {}
                )
        }
    }
}

struct NumberInput_Previews: PreviewProvider {
    @State static private var value: String = "000"

    static var previews: some View {
        NumberInput(labelText: "number", value: $value)
    }
}
