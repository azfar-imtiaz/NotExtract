//
//  HomeView.swift
//  NoteCapture
//
//  Created by Azfar Imtiaz on 2024-02-27.
//

import SwiftUI

struct HomeView: View {
    @State private var isCameraPresented : Bool   = false
    @State private var isTextExtracted   : Bool   = false
    @State private var isTextSaved       : Bool   = false
    @State private var extractedText     : String = ""
    @State private var capturedImage     : UIImage?
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                VStack {
                    if let capturedImage {
                        VStack {
                            if isTextSaved {
                                Spacer()
                                NoteCardView(noteText: extractedText)
                                    .frame(width: 100, height: 100)
                                    .padding()
                                Spacer()
                            } else {
                                Image(uiImage: capturedImage)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(.rect(cornerSize: CGSize(width: 8, height: 8)))
                                    .padding()
                                
                                Spacer()
                                
                                Button {
                                    let visionImage = viewModel.prepareImage(image: capturedImage)
                                    viewModel.processText(image: visionImage) { textResult, error in
                                        if error != nil {
                                            print("Error occurred!")
                                        } else if let textResult = textResult {
                                            var texts = [String]()
                                            extractedText.removeAll()
                                            for block in textResult.blocks {
                                                texts.append(block.text)
                                            }
                                            extractedText = texts.joined(separator: "\n")
                                            isTextExtracted = true
                                        }
                                    }
                                } label: {
                                    Text("Extract text")
                                        .font(.system(size: 20))
                                        .bold()
                                }
                                .buttonStyle(.borderedProminent)
                                .padding()
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.capturedImage = nil
                        self.extractedText = ""
                        self.isTextExtracted = false
                        self.isTextSaved = false
                        self.isCameraPresented.toggle()
                    }) {
                        Image(systemName: "camera")
                            .font(.system(size: 50))
                            .padding()
                            .background(.blue)
                            .foregroundStyle(.white)
                            .clipShape(.circle)
                    }
                    .sheet(isPresented: $isCameraPresented) {
                        CameraView(isPresented: $isCameraPresented, capturedImage: self.$capturedImage)
                    }
                    .sheet(isPresented: $isTextExtracted, onDismiss: saveExtractedText) {
                        ExtractedTextView(extractedText: self.$extractedText)                        
                    }
                }
                .navigationTitle("NotExtract")
                .padding(.vertical)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func saveExtractedText() {
        self.isTextSaved = true
    }
}

#Preview {
    HomeView()
}
