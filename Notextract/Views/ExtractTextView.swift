//
//  ExtractedTextView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-02-27.
//

import SwiftUI

struct ExtractTextView: View {
    var sender: Any?
    @Binding var capturedImage: UIImage?
    @State var extractedText : String = ""
    @State var extractTextFromImage : Bool = false
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = ExtractTextViewModel()
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                extractTextView(image: capturedImage)
            }
            .tint(.charcoal)
        } else {
            NavigationView {
                extractTextView(image: capturedImage)
            }
            .tint(.charcoal)
        }
    }
}

extension ExtractTextView {
    
    func extractTextView(image: UIImage?) -> some View {
        VStack {
            NavigationLink(destination: extractedTextView(), isActive: $extractTextFromImage) {
                EmptyView()
            }
            
            if capturedImage != nil {
                
                Spacer()
                
                Image(uiImage: capturedImage!)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerSize: CGSize(width: 8, height: 8)))
                    .padding()
                
                Spacer()
                
                HStack(spacing: 20) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.customFont("LeagueSpartan-Regular", size: 20))
                            .frame(width: 70)
                            .foregroundStyle(.ivoryAlways)
                            .padding()
                            .background(.puce)
                            .roundedCorner(8, corners: .allCorners)
                    }
                    
                    Button {
                        extractedText = viewModel.extractTextFromImage(image: capturedImage!)
                        extractTextFromImage.toggle()
                    } label: {
                        Text("Extract text")
                            .font(.customFont("LeagueSpartan-Regular", size: 20))
                            .frame(maxWidth: 100)
                            .foregroundStyle(.ivoryAlways)
                            .padding()
                            .background(.gold)
                            .roundedCorner(8, corners: .allCorners)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Extract text")
        .background(
            DotPattern(
                backgroundColor: .ivory,
                dotColor: .charcoal,
                opacity: 0.15,
                spacing: 7
            )
        )
        
    }
    
    func extractedTextView() -> some View {
        VStack {
            Spacer()
            
            HStack {
                Text("NOTE TITLE")
                    .font(.customFont("LeagueSpartan-Bold", size: 18))
                    .foregroundStyle(.charcoal)
                    .opacity(0.5)
                Spacer()
            }
            .padding(.horizontal)
                
            
            TextView(text: $extractedText, backgroundColor: UIColor(.ivory), textAlignment: .center, fontName: "Lora-Regular", fontSize: 18)
                .frame(height: UIScreen.main.bounds.height * 0.06)
                .padding([.horizontal, .bottom])
            
            HStack {
                Text("NOTE TEXT")
                    .font(.customFont("LeagueSpartan-Bold", size: 18))
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
                        .font(.customFont("LeagueSpartan-Regular", size: 20))
                        .frame(width: 70)
                        .foregroundStyle(.ivoryAlways)
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
                        .font(.customFont("LeagueSpartan-Regular", size: 20))
                        .frame(width: 70)
                        .foregroundStyle(.ivoryAlways)
                        .padding()
                        .background(.gold)
                        .roundedCorner(8, corners: .allCorners)
                }
            }
            .padding()
            
        }
        .navigationTitle("Extracted text")
        .background(
            DotPattern(
                backgroundColor: .ivory,
                dotColor: .charcoal,
                opacity: 0.15,
                spacing: 7
            )
        )
    }
    
    /*func textEditView() -> some View {
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
        .background(
            DotPattern(
                backgroundColor: .ivory,
                dotColor: .charcoal,
                opacity: 0.15,
                spacing: 7
            )
        )
    }*/
}

#Preview {
    // ExtractTextView(sender: "nil", extractedText: .constant("Text1"))
    ExtractTextView(sender: "nil", capturedImage: .constant(UIImage(named: "notExtract")), extractedText: "Lolz")
}
