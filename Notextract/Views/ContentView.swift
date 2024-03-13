//
//  ContentView.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-02-27.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authManager: AuthManager = AuthManager()
    var body: some View {
        ZStack {
            if authManager.authState == .loggedIn {
                HomeView()
            } else {
                LoginView(authManager: authManager)
            }
        }
        .animation(.smooth, value: authManager.authState)
    }
}

#Preview {
    ContentView()
}
