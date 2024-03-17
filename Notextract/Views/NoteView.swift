//
//  NoteView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-14.
//

import SwiftUI

struct NoteView: View {
    let note: Note
    var body: some View {
        VStack {
            Text(note.text)
        }
        .navigationTitle(note.title)
    }
}

#Preview {
    NoteView(note: Note(title: "Note title", text: "Note text", category: "Note", dateCreated: .now))
}
