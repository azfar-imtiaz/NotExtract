//
//  Note.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-08.
//

import Foundation

class Note {
    let id          : UUID
    let title       : String
    let text        : String
    let category    : String
    let dateCreated : Date
    
    init(title: String, text: String, category: String, dateCreated: Date) {
        self.id = UUID()
        self.title = title
        self.text = text
        self.category = category
        self.dateCreated = dateCreated
    }
    
    
}
