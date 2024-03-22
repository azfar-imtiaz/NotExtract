//
//  User.swift
//  Notextract
//
//  Created by Azfar Imtiaz on 2024-03-22.
//

import Foundation

class User: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let joiningDate: TimeInterval
    
    init(id: String, firstName: String, lastName: String, email: String, joiningDate: TimeInterval) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.joiningDate = joiningDate
    }
}
