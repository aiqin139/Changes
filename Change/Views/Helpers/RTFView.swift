//
//  RTFReader.swift
//  Change
//
//  Created by aiqin139 on 2021/3/17.
//

import SwiftUI

struct RTFReader: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    
    var fileName: String

    func makeUIView(context: Context) -> UITextView { UITextView() }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "rtf")!
        uiView.attributedText = try? NSAttributedString(url: url, options: [.documentType : NSAttributedString.DocumentType.rtf], documentAttributes: nil)
        uiView.isEditable = false
        uiView.textColor = (colorScheme == .dark) ? .white : .black
    }
}

struct RTFView: View {
    var fileName: String
    
    var body: some View {
        RTFReader(fileName: fileName)
    }
}

struct RTFView_Previews: PreviewProvider {
    static var previews: some View {
        RTFView(fileName: "license_cn")
    }
}
