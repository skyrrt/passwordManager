//
//  Group.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 13/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

struct Group: Codable {
    let id: String?
    let name: String
    let description: String
    
    init(id: String?, name: String,  description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}
