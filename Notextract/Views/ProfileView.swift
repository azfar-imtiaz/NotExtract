//
//  ProfileView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-21.
//

import SwiftUI

struct ProfileView: View {
    let firstName: String = "Azfar"
    let lastName: String = "Imtiaz"
    let email: String = "azfar.imtiaz@live.com"
    
    @State var firstNameUpdated: String = ""
    @State var lastNameUpdated: String = ""
    
    @FocusState private var isFieldFocused: Bool
    
    var body: some View {
        VStack {
            ZStack {
                CustomAvatar(imageURL: "nil", fallbackText: "AI", fallbackBgColor: .ivory, fallbackFgColor: .charcoal, width: 150, height: 150)
                Button {
                    print("Edit photo pressed!")
                } label: {
                    ZStack {
                        Circle()
                            .foregroundStyle(.ivory)
                            .frame(width: 40, height: 40)
                        Image(systemName: "pencil.line")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.gold)
                    }
                    .offset(x: 60, y: 35)
                    .shadow(radius: 10, x: 1, y: 1)
                    .padding()
                }
            }
            .padding()
            .opacity(isFieldFocused ? 0.0 : 1.0)
            
            Text("\(firstName) \(lastName)")
                .font(.customFont("LeagueSpartan-Bold", size: 25))
                .foregroundStyle(.charcoal)
                .padding(.bottom, 10)
                .opacity(isFieldFocused ? 0.0 : 1.0)
            
            Text(email)
                .font(.customFont("LeagueSpartan-Regular", size: 16))
                .foregroundStyle(.charcoal)
                .opacity(0.5)
                .padding(.bottom)
                .opacity(isFieldFocused ? 0.0 : 1.0)
            
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("FIRST NAME")
                        .font(.customFont("LeagueSpartan-Regular", size: 16))
                        .opacity(0.8)
                    Spacer()
                }
                .foregroundStyle(.charcoal)
                .padding()
                
                CustomTextField(placeholderText: firstName, color: .charcoal, text: $firstNameUpdated)
                    .underlineTextField(color: .charcoal)
                    .foregroundStyle(.charcoal)
                    .font(.customFont("LeagueSpartan-Regular", size: 20))
                    .padding([.horizontal, .bottom])
                    .focused($isFieldFocused)
                
                HStack {
                    Text("LAST NAME")
                        .font(.customFont("LeagueSpartan-Regular", size: 16))
                        .opacity(0.8)
                    Spacer()
                }
                .foregroundStyle(.charcoal)
                .padding()
                
                CustomTextField(placeholderText: lastName, color: .charcoal, text: $lastNameUpdated)
                    .underlineTextField(color: .charcoal)
                    .foregroundStyle(.charcoal)
                    .font(.customFont("LeagueSpartan-Regular", size: 20))
                    .padding([.horizontal, .bottom])
                    .focused($isFieldFocused)
                
                HStack {
                    Text("SOME STATISTICS?")
                        .font(.customFont("LeagueSpartan-Regular", size: 16))
                        .opacity(0.8)
                    Spacer()
                }
                .foregroundStyle(.charcoal)
                .padding()
                
                Spacer()
            }
        }
        .keyboardAdaptive()
        .background(.ivory)
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ProfileView().preferredColorScheme($0)
        }
    }
}
