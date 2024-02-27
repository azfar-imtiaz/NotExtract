//
//  HomeView.swift
//  NoteCapture
//
//  Created by Azfar Imtiaz on 2024-02-27.
//

import SwiftUI

struct HomeView: View {
    @State private var isCameraPresented: Bool = false
    @State private var isTextExtracted: Bool = false
    @State private var capturedImage: UIImage?
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let capturedImage {
                    VStack {
                        Image(uiImage: capturedImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerSize: CGSize(width: 8, height: 8)))
                            .padding()
                        
                        Spacer()
                        
                        Button {
                            print("Text conversion begins!")
                            let visionImage = viewModel.prepareImage(image: capturedImage)
                            viewModel.processText(image: visionImage) { text, error in
                                if error != nil {
                                    print("Error occurred!")
                                } else if let text = text {
                                    print("Extracted text: \(text.text)")
                                }
                            }
                        } label: {
                            Text("Extract text")
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                    
                }
                
                Spacer()
                
                Button(action: {
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
            }
            .navigationTitle("NoteCapture")
            .padding(.vertical)
        }
    }
}

#Preview {
    HomeView()
}
