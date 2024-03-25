//
//  LoginViewModel.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-22.
//

import Foundation

class LoginViewModel: ObservableObject {
    let errorCode = 401
    var errorMessage: String? = nil
    let authManager: AuthManager
    
    init(errorMessage: String? = nil, authManager: AuthManager) {
        self.errorMessage = errorMessage
        self.authManager = authManager
    }
    
    func login(email: String, password: String, completion: @escaping (Result<User, NSError>) -> Void) {
        let domain = "login"
        guard runLoginValidations(email: email, password: password) else {
            completion(.failure(NSError(
                domain: domain,
                code: errorCode,
                userInfo: [NSLocalizedDescriptionKey: errorMessage ?? "Unknown error."])
            ))
            return
        }
        
        authManager.login(email: email, password: password, completion: completion)
    }
    
    func signUp(firstName: String, lastName: String, email: String, password: String, repeatPassword: String, completion: @escaping (Result<User, NSError>) -> Void) {
        let domain = "signup"
        guard runSignupValidations(firstName: firstName, lastName: lastName, email: email, password: password, repeatPassword: repeatPassword) else {
            completion(.failure(NSError(
                domain: domain,
                code: errorCode,
                userInfo: [NSLocalizedDescriptionKey: errorMessage ?? "Unknown error."])
            ))
            return
        }
        
        authManager.signUp(firstName: firstName, lastName: lastName, email: email, password: password, repeatedPassword: repeatPassword, completion: completion)
    }
    
    func runLoginValidations(email: String, password: String) -> Bool {
        guard validateEmail(email: email) else { return false }
        guard validatePassword(password: password) else { return false }
        return true
    }
    
    func runSignupValidations(firstName: String, lastName: String, email: String, password: String, repeatPassword: String) -> Bool {
        guard validatePasswords(password: password, repeatedPassword: repeatPassword) else { return false }
        guard validateName(name: firstName) && validateName(name: lastName) else { return false }
        guard validateEmail(email: email) else { return false }
        guard validatePassword(password: password) else { return false }
        return true
    }
    
    func validatePasswords(password: String, repeatedPassword: String) -> Bool {
        guard password == repeatedPassword else {
            errorMessage = "The passwords do not match."
            return false
        }
        return true
    }
    
    func validateName(name: String) -> Bool {
        guard name.trimmingCharacters(in: .whitespaces).count > 0 && name.containsOnlyLetters else {
            errorMessage = "Invalid first or last name."
            return false
        }
        return true
    }
    
    func validateEmail(email: String) -> Bool {
        guard email.trimmingCharacters(in: .whitespaces).count > 0,
              email.contains("@"),
              email.contains(".") else {
            errorMessage = "Please enter a valid email address."
            return false
        }
        return true
    }
    
    func validatePassword(password: String) -> Bool {
        guard password.count >= 6 else {
            errorMessage = "The password should be at least 6 characters."
            return false
        }
        return true
    }
}
