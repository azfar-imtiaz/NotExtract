//
//  NoteCardView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-03.
//

import SwiftUI

struct NoteCardView: View {
    let noteText: String
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                    .foregroundStyle(Color.gray)
            }
            VStack {
                Text(noteText)
                    .padding()
            }
        }
    }
}

#Preview {
    NoteCardView(noteText: "Hello, this is a \ntemporary note")
}
