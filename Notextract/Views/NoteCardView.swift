//
//  NoteCardView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-03.
//

import SwiftUI

struct NoteCardView: View {
    let note: Note
    var body: some View {
        VStack(alignment: .center) {
            Text(note.title)
                .font(.customFont("LeagueSpartan-Bold", size: 18))
                .foregroundStyle(.ivory)
            
            Spacer()
            
            Text(note.text)
                .font(.customFont("LeagueSpartan-Regular", size: 15))
                .foregroundStyle(.ivory)
                .multilineTextAlignment(.leading)
                .lineLimit(4)
            
            Spacer()
            
            Text(note.dateCreated, style: .date)
                .font(.customFont("LeagueSpartan-Regular", size: 12))
                .foregroundStyle(.ivory)
                .opacity(0.8)
        }
        .padding()
        .background(.charcoal)
        .roundedCorner(10, corners: .allCorners)
    }
}

#Preview {
    NoteCardView(
        note: Note(
            title: "Note title",
            text: "Note text. This is the text of the note that has been crafted for testing purposes.",
            category: "Note",
            dateCreated: .now
        )
        )
}
