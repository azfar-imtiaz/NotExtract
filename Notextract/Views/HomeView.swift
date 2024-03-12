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
            if viewModel.notesList.count == 0 {
                HStack {
                    Text("CREATE YOUR FIRST NOTE!")
                        .font(.customFont("LeagueSpartan-Bold", size: 20))
                        .foregroundStyle(.charcoal)
                        .opacity(0.5)
                    Spacer()
                }
                .padding(.top,  50)
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
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .padding(.vertical)
                .listStyle(.plain)
            }
            
            Spacer()
            
            /*NavigationLink(destination: CameraView(isPresented: $isCameraPresented, capturedImage: self.$capturedImage), isActive: $isCameraPresented) {
                EmptyView()
            }*/
            
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
            .sheet(isPresented: $isCameraPresented, onDismiss: {
                if capturedImage != nil {
                    isTextExtracted.toggle()
                }
            }) {
                CameraView(isPresented: $isCameraPresented, capturedImage: self.$capturedImage)
                    .background(.black)
            }
            .sheet(isPresented: $isTextExtracted) {
                ExtractTextView(sender: self, capturedImage: capturedImage)
            }
        }
        .navigationTitle("notExtract")
        .padding()
        .background(
            DotPattern(
                backgroundColor: .ivory,
                dotColor: .charcoal,
                opacity: 0.15,
                spacing: 7
            )
        )
    }
}

#Preview {
    HomeView()
}
