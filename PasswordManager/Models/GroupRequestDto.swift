//
//  GroupRequestDto.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 01/12/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

class GroupRequestDto: Codable {
    var id: String?
    let groupId: String
    let userId: String
    
    init(id: String?, groupId: String, userId: String) {
        self.id = id
        self.groupId = groupId
        self.userId = userId
    }
}
