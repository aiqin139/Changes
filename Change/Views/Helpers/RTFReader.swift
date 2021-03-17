//
//  RTFReader.swift
//  Change
//
//  Created by aiqin139 on 2021/3/17.
//

import SwiftUI

struct RTFReader: UIViewRepresentable {
    typealias uiTextView = UITextView
    var configuration = { (view: uiTextView) in }
    var fileName: String

    func makeUIView(context: UIViewRepresentableContext<Self>) -> uiTextView { uiTextView() }
    
    func updateUIView(_ uiView: uiTextView, context: UIViewRepresentableContext<Self>) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "rtf")!
        uiView.attributedText = try? NSAttributedString(url: url, options: [.documentType : NSAttributedString.DocumentType.rtf], documentAttributes: nil)
        uiView.isEditable = false
        configuration(uiView)
    }
}
