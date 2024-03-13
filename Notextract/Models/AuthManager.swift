//
//  AuthManager.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-13.
//

import Foundation

enum AuthState {
    case loggedIn
    case loggedOut
}

class AuthManager: ObservableObject {
    @Published var authState: AuthState = .loggedOut
    
    func login(username: String, password: String) -> Bool {
        guard username.count > 0 && password.count > 0 else {
            return false
        }
        // put login logic here
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.authState = .loggedIn
        }
        return true
    }
    
    func logout() {
        self.authState = .loggedOut
    }
}
