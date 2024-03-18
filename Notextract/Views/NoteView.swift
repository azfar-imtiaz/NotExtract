//
//  NoteView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-14.
//

import SwiftUI

struct NoteView: View {
    var note: Note
    @State var updatedNoteTitle: String = ""
    @State var updatedNoteText: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                noteView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        note.title = updatedNoteTitle
                        note.text = updatedNoteText
                        note.dateCreated = .now
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.gold)
                            .frame(width: 25, height: 25)
                    }
                }
            }
        } else {
            NavigationView {
                noteView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        note.title = updatedNoteTitle
                        note.text = updatedNoteText
                        note.dateCreated = .now
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.gold)
                            .frame(width: 25, height: 25)
                    }
                }
            }
        }
    }
    
    func noteView() -> some View {
        VStack {
            Divider()
                .padding()
            
            VStack(alignment: .leading) {
                Text(note.dateCreated, style: .date)
                    .font(.customFont("LeagueSpartan-Regular", size: 18))
                    .foregroundStyle(.charcoal)
                    .opacity(0.5)
                    .padding(.bottom)
                
                TextView(text: $updatedNoteTitle, backgroundColor: .clear, textAlignment: .left, fontName: "LeagueSpartan-Bold", fontSize: 30, showBorder: false)
                    .foregroundStyle(.charcoal)
                    .frame(height: 35)
                    .padding(.bottom)
                
                TextView(text: $updatedNoteText, backgroundColor: .clear, textAlignment: .justified, fontName: "LeagueSpartan-Regular", fontSize: 20, showBorder: false)
                    .foregroundStyle(.charcoal)
            }
            .padding()
            
            Spacer()
        }
        .background(
            DotPattern(
                backgroundColor: .ivory,
                dotColor: .charcoal,
                opacity: 0.15,
                spacing: 7
            )
        )
        .onAppear {
            updatedNoteTitle = note.title
            updatedNoteText = note.text
        }
    }
}

#Preview {
    NoteView(note: Note(title: "Note title", text: "Note text", category: "Note", dateCreated: .now))
}
