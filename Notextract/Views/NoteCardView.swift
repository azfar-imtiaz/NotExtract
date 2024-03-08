//
//  NoteCardView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-03.
//

import SwiftUI

struct NoteCardView: View {
    let noteTitle : String
    let noteText  : String
    var body: some View {
        VStack(alignment: .leading) {
            Text(noteTitle)
                .font(.customFont("LeagueSpartan-Bold", size: 20))
                .foregroundStyle(.ivory)
            
            Spacer()
            
            Text(noteText)
                .font(.customFont("LeagueSpartan-Regular", size: 15))
                .foregroundStyle(.ivory)
        }
        .padding()
        .frame(width: 150, height: 120)
        .background(.charcoal)
        .roundedCorner(20, corners: .allCorners)
    }
}

#Preview {
    NoteCardView(
        noteTitle: "Note title",
        noteText: "Hello, this is a \ntemporary note. It contains the following information: \n - Rice \n - Beans")
}
