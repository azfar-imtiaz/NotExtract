//
//  ExtractedTextView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-02-27.
//

import SwiftUI

struct ExtractedTextView: View {
    var sender: Any?
    @Binding var extractedText: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                textEditView()
            }
        } else {
            NavigationView {
                textEditView()
            }
        }
    }
}

extension ExtractedTextView {
    func textEditView() -> some View {
        VStack {
            Spacer()
            
//            TextEditor(text: $extractedText)
//                .font(.customFont("LeagueSpartan-Regular", size: 22))
//                .roundedCorner(20, corners: .allCorners)
//                .foregroundStyle(.charcoal)
//                .padding()
//                // .textEditorStyle(.plain)
//            }
            
            HStack {
                Text("NOTE TITLE")
                    .font(.customFont("LeagueSpartan-Bold", size: 20))
                    .foregroundStyle(.charcoal)
                    .opacity(0.5)
                Spacer()
            }
            .padding(.horizontal)
                
            
            TextView(text: $extractedText, backgroundColor: UIColor(.ivory), textAlignment: .center, fontName: "Lora-Regular", fontSize: 18)
                .frame(height: UIScreen.main.bounds.height * 0.08)
                .padding([.horizontal, .bottom])
            
            HStack {
                Text("NOTE TEXT")
                    .font(.customFont("LeagueSpartan-Bold", size: 20))
                    .foregroundStyle(.charcoal)
                    .opacity(0.5)
                Spacer()
            }
            .padding(.horizontal)
            
            TextView(text: $extractedText, backgroundColor: UIColor(.ivory), textAlignment: .justified, fontName: "Lora-Regular", fontSize: 16)
                .padding([.horizontal, .bottom])
            
            Spacer()
            
            HStack(spacing: 20) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(.customFont("LeagueSpartan-Regular", size: 25))
                        .frame(width: 70)
                        .foregroundStyle(.ivory)
                        .padding()
                        .background(.puce)
                        .roundedCorner(8, corners: .allCorners)
                }
                
                Button {
                    if let sender = sender as? HomeView {
                        sender.saveExtractedText(text: extractedText)
                    }
                    dismiss()
                } label: {
                    Text("Save")
                        .font(.customFont("LeagueSpartan-Regular", size: 25))
                        .frame(width: 70)
                        .foregroundStyle(.ivory)
                        .padding()
                        .background(.gold)
                        .roundedCorner(8, corners: .allCorners)
                }
            }
            
            Spacer()
            
        }
        .navigationTitle("Extracted text")
        .background(.ivory)
    }
}

#Preview {
    ExtractedTextView(sender: "nil", extractedText: .constant("Text1"))
}
