//
//  RTFReader.swift
//  Changes
//
//  Created by aiqin139 on 2021/3/17.
//

import SwiftUI

struct UIRTFView: UIViewRepresentable {
    var fileName: String

    func makeUIView(context: Context) -> UITextView {
        UITextView()
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "rtf")!
        uiView.attributedText = try? NSAttributedString(url: url, options: [.documentType : NSAttributedString.DocumentType.rtf], documentAttributes: nil)
        uiView.isEditable = false
        uiView.textColor = (UITraitCollection.current.userInterfaceStyle == .dark) ? .white : .black
        uiView.backgroundColor = (UITraitCollection.current.userInterfaceStyle == .dark) ? .black : .white
    }
}

struct RTFReader: View {
    var fileName: String
    
    var body: some View {
        UIRTFView(fileName: fileName)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 10, x: 0, y: 0)
            .padding()
    }
}

struct RTFReader_Previews: PreviewProvider {
    static var previews: some View {
        RTFReader(fileName: "软件许可")
    }
}
