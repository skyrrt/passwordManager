//
//  File.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 15/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

class GroupMembershipRequest: Codable {
    let userId: String
    let groupId: String
    
    init(userId: String, groupId: String) {
        self.userId = userId
        self.groupId = groupId
    }
}
