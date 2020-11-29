//
//  UserDetails.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 29/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

class UserDetails: Codable {
    let id: String
    let email: String
    let uid: String
    
    init(id: String, email: String, uid: String) {
        self.id = id
        self.email = email
        self.uid = uid
    }
}
