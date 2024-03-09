//
//  HomwViewModel.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-02-27.
//

import Foundation
// import MLKitTextRecognition
// import MLKitVision
import UIKit

class HomeViewModel: ObservableObject {
    
    // @Published var notesList = [Note]()
    @Published var notesList = [
        Note(title: "Title 1", text: "This is the text for Note 1", category: "Note", dateCreated: Date.now),
        Note(title: "Title 2", text: "This is the text for Note 2", category: "Note", dateCreated: Date.now),
        Note(title: "Title 3", text: "This is the text for Note 1", category: "Note", dateCreated: Date.now)
    ]
    
    func saveTextExtractedFromImage(text: String) {
        notesList.append(Note(title: "Note title", text: text, category: "Note", dateCreated: Date.now))
    }
    /*
     let latinOptions: TextRecognizerOptions
    let textRecognizer: TextRecognizer
    var extractedText = [String]()
    
    init() {
        latinOptions = TextRecognizerOptions()
        textRecognizer = TextRecognizer.textRecognizer(options: latinOptions)
    }
    
    func prepareImage(image: UIImage) -> VisionImage {
        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation
        return visionImage
    }
    
    func processText(image: VisionImage, completion: @escaping (Text?, Error?) -> Void) {
        textRecognizer.process(image) { result, error in
            guard error == nil, let result = result else {
                completion(nil, error)
                return
            }
            completion(result, nil)
            
            /*
            self.extractedText.removeAll()
            let resultText = result.text
            print("Result text: \(resultText)")
            for block in result.blocks {
                let blockText = block.text
                print("\t\(blockText)")
                self.extractedText.append(blockText)
                let blockLanguages = block.recognizedLanguages
                let blockCornerPoints = block.cornerPoints
                let blockFrame = block.frame
                for line in block.lines {
                    let lineText = line.text
                    print("\t\t\(lineText)")
                    let lineLanguages = line.recognizedLanguages
                    let lineCornerPoints = line.cornerPoints
                    let lineFrame = line.frame
                    for element in line.elements {
                        let elementText = element.text
                        print("\t\t\t\(elementText)")
                        let elementCornerPoints = element.cornerPoints
                        let elementFrame = element.frame
                    }
                }
            }
             */
        }
    }
     */
}
