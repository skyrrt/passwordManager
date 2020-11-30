//
//  GroupRequest.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 15/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

class GroupRequest {
    var id: String?
    var groupId: String
    var userId: String
    
    init(id: String?, groupId: String, userId: String) {
        self.groupId = groupId
        self.id = id
        self.userId = userId
    }
    
}
