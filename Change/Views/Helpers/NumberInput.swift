//
//  NumberInput.swift
//  Change
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
            
            TextField("0", text: $value)
                .keyboardType(UIKeyboardType.numberPad)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .border(Color(UIColor.separator))
                .onTapGesture {}
                .onLongPressGesture(
                    pressing: { isPressed in if isPressed { self.EndEditing() } },
                    perform: {}
                )
        }
    }
}

struct NumberInput_Previews: PreviewProvider {
    @State static private var value: String = "0"

    static var previews: some View {
        NumberInput(labelText: "number", value: $value)
    }
}
