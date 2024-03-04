//
//  Coordinator.swift
//  NoteCapture
//
//  Created by Azfar Imtiaz on 2024-02-27.
//

import Foundation
import UIKit

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: CameraView
    
    init(picker: CameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.capturedImage = selectedImage
        self.picker.isPresented = false
    }
}
