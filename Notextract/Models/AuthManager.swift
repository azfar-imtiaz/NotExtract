//
//  AuthManager.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-13.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum AuthState {
    case loggedIn
    case loggedOut
}

class AuthManager: ObservableObject {
    @Published var authState: AuthState = .loggedOut
    
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        guard validateEmail(email: email) else {
            completion(NSError(
                domain: "signup",
                code: 401,
                userInfo: [NSLocalizedDescriptionKey: "Please enter a valid email address"])
            )
            return
        }
        
        guard validatePassword(password: password) else {
            completion(NSError(
                domain: "signup",
                code: 401,
                userInfo: [NSLocalizedDescriptionKey: "The password should contain at least 6 characters"])
            )
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
                return
            } else if let authResult = authResult {
                let userID = authResult.user.uid
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(userID)
                userRef.getDocument { document, error in
                    if let error = error {
                        completion(error)
                        return
                    }
                    if let document = document, document.exists {
                        do {
                            let user = try document.data(as: User.self)
                            print("\(user.firstName) \(user.lastName) has logged in!")
                            self.authState = .loggedIn
                        } catch {
                            completion(NSError(
                                domain: "login",
                                code: 401,
                                userInfo: [NSLocalizedDescriptionKey: "Error decoding user data."])
                            )
                        }
                    } else {
                        completion(NSError(
                            domain: "login",
                            code: 401,
                            userInfo: [NSLocalizedDescriptionKey: "Error retrieving user data."])
                        )
                    }
                }
            }
        }
    }
    
    func logout() {
        self.authState = .loggedOut
    }
    
    func signUp(firstName: String, lastName: String, email: String, password: String, repeatedPassword: String, completion: @escaping (Error?) -> Void) {
        guard password == repeatedPassword else {
            // should be completion handler here
            completion(NSError(
                domain: "signup",
                code: 401,
                userInfo: [NSLocalizedDescriptionKey: "Passwords do not match!"])
            )
            return
        }
        
        guard validateName(name: firstName) && validateName(name: lastName) else {
            completion(NSError(
                domain: "signup",
                code: 401,
                userInfo: [NSLocalizedDescriptionKey: "Invalid first or last name"])
            )
            return
        }
        
        guard validateEmail(email: email) else {
            completion(NSError(
                domain: "signup",
                code: 401,
                userInfo: [NSLocalizedDescriptionKey: "Please enter a valid email address"])
            )
            return
        }
        
        guard validatePassword(password: password) else {
            // should be completion handler here
            completion(NSError(
                domain: "signup",
                code: 401,
                userInfo: [NSLocalizedDescriptionKey: "The password should contain at least 6 characters"])
            )
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
                return
            } else {
                if let userId = authResult?.user.uid {
                    let newUser = User(id: userId, firstName: firstName, lastName: lastName, email: email, joiningDate: Date().timeIntervalSince1970)
                    let db = Firestore.firestore()
                    db.collection("users")
                        .document(userId)
                        .setData(newUser.asDictionary())
                    
                    // log the user in
                    self.authState = .loggedIn
                }
            }
        }
    }
    
    func validateName(name: String) -> Bool {
        guard name.trimmingCharacters(in: .whitespaces).count > 0 && name.containsOnlyLetters else {
            return false
        }
        return true
    }
    
    func validateEmail(email: String) -> Bool {
        guard email.trimmingCharacters(in: .whitespaces).count > 0,
              email.contains("@"),
              email.contains(".") else {
            return false
        }
        return true
    }
    
    func validatePassword(password: String) -> Bool {
        guard password.count >= 6 else {
            return false
        }
        return true
    }
}
