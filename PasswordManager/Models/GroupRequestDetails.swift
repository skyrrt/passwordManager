//
//  GroupRequestDetails.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 15/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

class GroupRequestDetails {
    
    var group: Group
    var user: User
    var requestId: String
    
    init (group: Group, user: User, requestId: String) {
        self.group = group
        self.user = user
        self.requestId = requestId
    }
}
