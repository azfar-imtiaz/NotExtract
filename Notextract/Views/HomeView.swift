//
//  HomeView.swift
//  NoteCapture
//
//  Created by Azfar Imtiaz on 2024-02-27.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var authManager: AuthManager
    
    @State private var isCameraPresented : Bool   = false
    @State private var extractTextFlag   : Bool   = false
    @State private var isTextSaved       : Bool   = false
    @State private var extractedText     : String = ""
    @State private var capturedImage     : UIImage?
    @State private var isNoteSelected : Bool = false
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                homeScreenView()
            }
            .tint(.charcoal)
        } else {
            NavigationView {
                homeScreenView()
            }
            .tint(.charcoal)
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
                .padding(.top,  30)
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(0..<viewModel.notesList.count, id: \.self) { index in
                            NavigationLink(destination: NoteView(note: viewModel.notesList[index])) {
                                NoteCardView(note: viewModel.notesList[index])
                                    .frame(width: UIScreen.main.bounds.width * 0.45, height: 200)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.vertical)
                }
            }
            
            Spacer()
            
            Button(action: {
                self.capturedImage = nil
                self.extractedText = ""
                self.extractTextFlag = false
                self.isTextSaved = false
                self.isCameraPresented = true
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
                    extractTextFlag = true
                }
            }) {
                CameraView(isPresented: $isCameraPresented, capturedImage: self.$capturedImage)
                    .background(.black)
            }
            .sheet(isPresented: $extractTextFlag) {
                ExtractTextView(sender: self, capturedImage: self.$capturedImage)
            }
        }
        .navigationTitle("notExtract")
        .navigationBarTitleDisplayMode(.automatic)
        .padding()
        .background(
            DotPattern(
                backgroundColor: .ivory,
                dotColor: .charcoal,
                opacity: 0.15,
                spacing: 7
            )
        )
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    
                    Button {
                        print("Settings pressed!")
                    } label: {
                        HStack(spacing: 0) {
                            Text("Settings")
                            Image(systemName: "gearshape")
                        }
                    }
                    
                    Button {
                        print("Profile pressed!")
                    } label: {
                        HStack(spacing: 0) {
                            Text("Profile")
                            Image(systemName: "person.crop.circle")
                        }
                    }
                    
                    Divider()
                    
                    Button(role: .destructive) {
                        authManager.authState = .loggedOut
                    } label: {
                        HStack(spacing: 0) {
                            Text("Log out")
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                        }
                        .tint(.puce)
                        .background(.charcoal)
                    }
                } label: {
                    Label("Menu", systemImage: "ellipsis.circle")
                        .foregroundStyle(.charcoal)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HomeView(authManager: AuthManager()).preferredColorScheme($0)
        }
    }
}
