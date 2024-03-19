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
    var showBorder: Bool = true
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = backgroundColor
        textView.textColor = .charcoal
        if showBorder {
            textView.layer.borderColor = UIColor(named: "charcoal")?.cgColor
            textView.layer.borderWidth = 1.5
            textView.layer.cornerRadius = 8
            textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)            
        }
        textView.textAlignment = textAlignment
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

struct CustomTextField: View {
    var placeholderText: String
    var color: Color
    @Binding var text: String
    
    var body: some View {
        if #available(iOS 17.0, *) {
            TextField(
                placeholderText,
                text: $text,
                prompt: Text(placeholderText)
                    .foregroundStyle(color.opacity(0.5))
            )
        } else {
            // Fallback on earlier versions
            // This will require creating a custom TextField using UIViewRepresentable. Check the first answer on this post: https://stackoverflow.com/questions/61338026/how-can-i-adjust-textfield-placeholder-color-swiftui
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholderText)
                        .foregroundStyle(color)
                        .opacity(0.5)
                } else {
                    TextField("", text: $text)
                }
            }
        }
    }
}


struct CustomSecureField: View {
    var placeholderText: String
    var color: Color
    @Binding var text: String
    
    var body: some View {
        if #available(iOS 17.0, *) {
            SecureField(
                placeholderText,
                text: $text,
                prompt: Text(placeholderText)
                    .foregroundStyle(color.opacity(0.5))
            )
        } else {
            // Fallback on earlier versions
            // This will require creating a custom TextField using UIViewRepresentable. Check the first answer on this post: https://stackoverflow.com/questions/61338026/how-can-i-adjust-textfield-placeholder-color-swiftui
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholderText)
                        .foregroundStyle(color)
                        .opacity(0.5)
                } else {
                    SecureField("", text: $text)
                }
            }
        }
    }
}
