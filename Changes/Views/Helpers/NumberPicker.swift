//
//  NumberPicker.swift
//  Changes
//
//  Created by aiqin139 on 2021/2/18.
//

import SwiftUI

struct NumberPicker: UIViewRepresentable {
    var format: String = "%d"
    var start: Int = 0
    var end: Int = 9
    @Binding var value: Int
    
    func makeCoordinator() -> NumberPicker.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        
        picker.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        uiView.selectRow($value.wrappedValue - start, inComponent: 0, animated: false)
    }
    
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var picker: NumberPicker
      
        init(_ pickerView: NumberPicker) {
            picker = pickerView
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return picker.end - picker.start + 1
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return String(format: picker.format, picker.start + row)
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            picker.$value.wrappedValue = Int(picker.start + row)
        }
    }
}

struct NumberPicker_Previews: PreviewProvider {
    @State static private var value1: Int = 0
    @State static private var value2: Int = 1
    @State static private var value3: Int = 2
    
    static var previews: some View {
        HStack {
            NumberPicker(format: "%03d", start: 0, end: 999, value: $value1)
            NumberPicker(format: "%03d", start: 0, end: 999, value: $value2)
            NumberPicker(format: "%03d", start: 0, end: 999, value: $value3)
        }
    }
}
