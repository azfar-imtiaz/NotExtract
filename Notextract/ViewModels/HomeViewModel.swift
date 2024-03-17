//
//  HomwViewModel.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-02-27.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    // @Published var notesList = [Note]()
    @Published var notesList = [
        Note(title: "Title 1", text: "This is the text for Note 1", category: "Note", dateCreated: Date.now),
        Note(title: "Title 2", text: "This is the text for Note 2. It comprises of multiple lines for a better idea of the user interface.", category: "Note", dateCreated: Date.now),
        Note(title: "Title 3", text: "This is the text for Note 1", category: "Note", dateCreated: Date.now)
    ]
    
    func saveTextExtractedFromImage(text: String) {
        notesList.append(Note(title: "Note title", text: text, category: "Note", dateCreated: Date.now))
    }
    
}
