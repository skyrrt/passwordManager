//
//  GroupDetails.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 15/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

class GroupDetails: Codable {
    let id: String?
    let groupName: String
    let createdBy: String?
    
    init(id: String?, groupName: String, createdBy: String?) {
        self.id = id
        self.groupName = groupName
        self.createdBy = createdBy
    }
    
}
