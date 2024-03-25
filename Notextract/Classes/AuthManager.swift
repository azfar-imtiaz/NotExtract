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
    
    func login(email: String, password: String, completion: @escaping (Result<User, NSError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error as NSError))
                return
            } else if let authResult = authResult {
                let userID = authResult.user.uid
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(userID)
                userRef.getDocument { document, error in
                    if let error = error {
                        completion(.failure(error as NSError))
                        return
                    }
                    if let document = document, document.exists {
                        do {
                            let user = try document.data(as: User.self)
                            print("\(user.firstName) \(user.lastName) has logged in!")
                            self.authState = .loggedIn
                            completion(.success(user))
                        } catch {
                            completion(.failure(NSError(
                                domain: "login",
                                code: 401,
                                userInfo: [NSLocalizedDescriptionKey: "Error decoding user data."])
                            ))
                        }
                    } else {
                        completion(.failure(NSError(
                            domain: "login",
                            code: 401,
                            userInfo: [NSLocalizedDescriptionKey: "Error retrieving user data."])
                        ))
                    }
                }
            }
        }
    }
    
    func logout() {
        self.authState = .loggedOut
    }
    
    func signUp(firstName: String, lastName: String, email: String, password: String, repeatedPassword: String, completion: @escaping (Result<User, NSError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error as NSError))
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
                    completion(.success(newUser))
                }
            }
        }
    }
}
