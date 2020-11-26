//
//  PasswordDetails.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 05/07/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

class PasswordDetails: Codable {
    let id: String?
    let vendorName: String
    let passwordHash: String
    let userAccount: String
    let userId: String
    let groupId: String?
    
    init(id: String?, vendorName: String, passwordHash: String, userAccount: String, userId: String, groupId: String?){
        self.vendorName = vendorName
        self.passwordHash = passwordHash
        self.userAccount = userAccount
        self.userId = userId
        self.groupId = groupId
        self.id = id
    }
    
    
}
