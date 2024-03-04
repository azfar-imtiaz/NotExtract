//
//  ExtractedTextView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-02-27.
//

import SwiftUI

struct ExtractedTextView: View {
    @Binding var extractedText: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                VStack {
                    Spacer()
                    
                    TextEditor(text: $extractedText)
                        .foregroundStyle(.secondary)
                        .padding()
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.system(size: 20))
                            .bold()
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    
                }
                .navigationTitle("Extracted text")
            }
        } else {
            NavigationView {
                VStack {
                    Spacer()
                    
                    TextEditor(text: $extractedText)
                        .foregroundStyle(.secondary)
                        .padding()
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.system(size: 20))
                            .bold()
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    
                }
                .navigationTitle("Extracted text")
            }
        }
    }
}

#Preview {
    ExtractedTextView(extractedText: .constant("Text 1"))
}
