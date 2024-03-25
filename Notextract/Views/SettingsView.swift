//
//  ProfileView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-20.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()
    @EnvironmentObject var userStore: UserStore
    
    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 20) {
                    CustomAvatar(
                        imageURL: "nil",
                        fallbackText: "\(userStore.loggedInUser?.firstName.first ?? "U")\(userStore.loggedInUser?.lastName.first ?? "U")",
                        fallbackBgColor: .ivory,
                        fallbackFgColor: .charcoal,
                        width: 110,
                        height: 110
                    )
                    .padding(.trailing)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("\(userStore.loggedInUser?.firstName ?? "Unknown") \(userStore.loggedInUser?.lastName ?? "User")")
                            .font(.customFont("LeagueSpartan-Bold", size: 25))
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(userStore.loggedInUser?.email ?? "Unknown email address")")
                                .font(.customFont("LeagueSpartan-Regular", size: 16))
                                .opacity(0.5)
                            
                            NavigationLink(destination: ProfileView()) {
                                HStack {
                                    Text("Edit profile")
                                        .font(.customFont("LeagueSpartan-Regular", size: 16))
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundStyle(.gold)
                            }
                        }
                    }
                    .foregroundStyle(.ivory)
                }
                
                Divider()
                    .overlay(.ivory)
                    .padding()
                
                HStack(spacing: 0) {
                    Text("Member since ")
                    // TODO: Fix this with joiningDate from userStore.loggedInUser.joiningDate
                    Text(.now, style: .date)
                    
                    Spacer()
                }
                .padding(.leading)
                .foregroundStyle(.ivory)
                .font(.customFont("LeagueSpartan-Regular", size: 16))
            }
            .padding()
            .background(.charcoal)
            .roundedCorner(12, corners: .allCorners)
            .frame(width: UIScreen.main.bounds.width * 0.9)
            
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("SETTINGS")
                        .font(.customFont("LeagueSpartan-Regular", size: 16))
                        .opacity(0.8)
                    Spacer()
                }
                .foregroundStyle(.charcoal)
                .padding(.vertical)
                
                HStack {
                    Text("Appearance")
                        .font(.customFont("LeagueSpartan-Regular", size: 20))
                    Spacer()
                }
                .foregroundStyle(.charcoal)
                
                Picker(selection: $viewModel.selectedMode, label: Text("Appearance")) {
                    Text("Light").tag(ColorSchemeMode.light)
                    Text("Automatic").tag(ColorSchemeMode.automatic)
                    Text("Dark").tag(ColorSchemeMode.dark)
                }
                .pickerStyle(.segmented)
                .padding()
                
                Divider()
                    .overlay(.charcoal)
                    .opacity(0.5)
                
                HStack {
                    Text("Here are some other settings")
                        .font(.customFont("LeagueSpartan-Regular", size: 20))
                    Spacer()
                }
                .foregroundStyle(.charcoal)
                .padding(.vertical)
                
                Divider()
                    .overlay(.charcoal)
                    .opacity(0.5)
                
                HStack {
                    Text("Version")
                        .font(.customFont("LeagueSpartan-Regular", size: 20))
                    Spacer()
                }
                .foregroundStyle(.charcoal)
                .padding(.vertical)
                
                Divider()
                    .overlay(.charcoal)
                    .opacity(0.5)
                
                HStack {
                    Text("Contact")
                        .font(.customFont("LeagueSpartan-Regular", size: 20))
                    Spacer()
                }
                .foregroundStyle(.charcoal)
                .padding(.vertical)
                
                Spacer()
            }
            .padding()
            .foregroundStyle(.charcoal)
            .onChange(of: viewModel.selectedMode) { _ in
                viewModel.saveMode()
            }
            
            Spacer()
        }
        .padding(.top, 50)
        .background(.ivory)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SettingsView().preferredColorScheme($0)
        }
    }
}
