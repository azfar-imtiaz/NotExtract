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
    @State private var isNoteSelected    : Bool = false
    @State private var extractedText     : String = ""
    @State private var capturedImage     : UIImage?
    
    
    @State private var searchText: String = ""
    
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
                .padding(.top, 30)
            } else {
                HStack {
                    Text("NotExtract")
                        .font(.customFont("Amsterdam-Two_ttf", size: 30))
                        .frame(height: 20)
                        .padding(.bottom)
                    Spacer()
                    Menu {
                        NavigationLink(destination: SettingsView()) {
                            Text("Settings")
                        }
                        
//                        Button {
//                            print("Profile pressed!")
//                        } label: {
//                            HStack(spacing: 0) {
//                                Text("Profile")
//                                Image(systemName: "person.crop.circle")
//                            }
//                        }
                        
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
                        Image(systemName: "ellipsis.circle")
                            .foregroundStyle(.charcoal.opacity(0.8))
                            .font(.title)
                    }
                }
                .padding(.vertical)
                
                CustomTextField(placeholderText: "Search", color: .charcoal, text: $searchText)
                    .background(.ivory)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8.0)
                            .strokeBorder(.charcoal.opacity(0.5), style: StrokeStyle(lineWidth: 1))
                    }
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(0..<viewModel.notesList.count, id: \.self) { index in
                            NavigationLink(destination: NoteView(note: viewModel.notesList[index])) {
                                NoteCardView(note: viewModel.notesList[index])
                                    .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.width * 0.45)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.vertical)
                }
            }
            
            Spacer()
            
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
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    print("Load from image pressed!")
                } label: {
                    Image(systemName: "photo")
                        .foregroundStyle(.charcoal)
                }
                
                Spacer()
                
                Button {
                    self.capturedImage = nil
                    self.extractedText = ""
                    self.extractTextFlag = false
                    self.isTextSaved = false
                    self.isCameraPresented = true
                } label: {
                    Image(systemName: "camera")
                        .foregroundStyle(.gold)
                        .font(.largeTitle)
                        .padding()
                }
                
                Spacer()
                
                Button {
                    print("Create text note pressed!")
                } label: {
                    Image(systemName: "square.and.pencil")
                        .foregroundStyle(.charcoal)
                }
            }
        }
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HomeView(authManager: AuthManager()).preferredColorScheme($0)
        }
    }
}
