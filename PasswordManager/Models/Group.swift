//
//  Group.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 13/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

struct Group: Codable {
    let groupName: String
    let createdBy: String
    
    init(groupName: String,  createdBy: String) {
        self.groupName = groupName
        self.createdBy = createdBy
    }
}
