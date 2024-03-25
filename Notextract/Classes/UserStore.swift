//
//  UserStore.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-23.
//

import Foundation

class UserStore: ObservableObject {
    @Published var loggedInUser: User?
}
