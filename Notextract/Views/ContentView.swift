//
//  ContentView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-02-27.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("colorSchemeMode") var selectedMode: ColorSchemeMode = .automatic
    @ObservedObject var authManager: AuthManager = AuthManager()
    
    var body: some View {
        ZStack {
            if authManager.authState == .loggedIn {
                HomeView(authManager: authManager)
                    .preferredColorScheme(selectedMode.systemColorScheme)
            } else {
                LoginView(authManager: authManager)
                    .preferredColorScheme(selectedMode.systemColorScheme)
            }
        }
        .animation(.smooth, value: authManager.authState)
    }
}

#Preview {
    ContentView()
}
