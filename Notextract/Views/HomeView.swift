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
                homeScreenView()
            }
        } else {
            NavigationView {
                homeScreenView()
            }
        }
    }
    
    func saveExtractedText(text: String) {
        viewModel.saveTextExtractedFromImage(text: text)
        self.isTextSaved = true
        self.capturedImage = nil
    }
}

extension HomeView {
    func homeScreenView() -> some View {
        VStack {
            if let capturedImage {
                if !isTextSaved {
                    VStack {
                        Image(uiImage: capturedImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerSize: CGSize(width: 8, height: 8)))
                            .padding()
                        
                        Spacer()
                        
                        Button {
                            /*
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
                             */
                            extractedText = "This is the placeholder extracted text"
                            isTextExtracted = true
                            
                        } label: {
                            Text("Extract text")
                                .font(.system(size: 20))
                                .bold()
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                }
            } else {
                let notesWithIndices = viewModel.notesList.enumerated().map({ $0 })
                List {
                    ForEach(notesWithIndices, id: \.element.id) {idx, note in
                        if idx % 2 == 0 {
                            let firstNote = note
                            let secondNote = idx + 1 < notesWithIndices.count ? viewModel.notesList[idx + 1] : nil
                            if idx == notesWithIndices.count - 1 {
                                HStack {
                                    NoteCardView(noteTitle: firstNote.title, noteText: firstNote.text)
                                    Spacer()
                                }
                            } else {
                                HStack(spacing: 5) {
                                    NoteCardView(noteTitle: firstNote.title, noteText: firstNote.text)
                                    Spacer()
                                    NoteCardView(noteTitle: secondNote!.title, noteText: secondNote!.text)
                                }
                            }
                        }
                    }
                    .listRowBackground(Color.ivory)
                    .listRowSeparator(.hidden)
                }
                .padding(.vertical)
                .listStyle(.plain)
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
                    .background(.gold)
                    .foregroundStyle(.white)
                    .clipShape(.circle)
            }
            .sheet(isPresented: $isCameraPresented) {
                CameraView(isPresented: $isCameraPresented, capturedImage: self.$capturedImage)
                    .background(.black)
            }
            .sheet(isPresented: $isTextExtracted) {
                ExtractedTextView(sender: self, extractedText: self.$extractedText)
            }
        }
        .navigationTitle("notExtract")
        .padding()
        .background(.ivory)
    }
}

#Preview {
    HomeView()
}
