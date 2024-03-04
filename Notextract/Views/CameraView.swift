//
//  CameraView.swift
//  NoteCapture
//
//  Created by Azfar Imtiaz on 2024-02-27.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var capturedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

#Preview {
    CameraView(isPresented: .constant(false), capturedImage: .constant(nil))
}
