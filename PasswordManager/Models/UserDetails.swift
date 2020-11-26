//
//  UserDetails.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 15/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

class UserDetails: Codable {
    var id: String
    var mail: String
    
    init(id: String, mail: String) {
        self.id = id
        self.mail = mail
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case mail
    }
    
    
}
