//
//  PasswordDetails.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 05/07/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

class PasswordDetails: Codable {
    let vendorName: String
    let passwordHash: String
    let userAccount: String
    let createdBy: String
    let groupId: String?
    
    init(vendorName: String, passwordHash: String, userAccount: String, createdBy: String, groupId: String?){
        self.vendorName = vendorName
        self.passwordHash = passwordHash
        self.userAccount = userAccount
        self.createdBy = createdBy
        self.groupId = groupId
    }
    
    enum CodingKeys: String, CodingKey {
        case vendorName
        case passwordHash
        case userAccount
        case createdBy
        case groupId
    }
    
}
