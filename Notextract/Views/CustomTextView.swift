//
//  CustomTextView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-09.
//

import Foundation
import SwiftUI

// Custom UITextView wrapper
struct TextView: UIViewRepresentable {
    @Binding var text: String
    var backgroundColor: UIColor
    var textAlignment: NSTextAlignment
    var fontName: String
    var fontSize: CGFloat
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = backgroundColor
        textView.textColor = .charcoal
        textView.layer.borderColor = Color.charcoal.cgColor
        textView.layer.borderWidth = 1.5
        textView.layer.cornerRadius = 8
        textView.textAlignment = .left
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.font = UIFont(name: fontName, size: fontSize)
        textView.text = text
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }
    }
}
