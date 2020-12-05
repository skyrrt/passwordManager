//
//  GroupRequest.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 01/12/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

class GroupRequestDetails: Codable {
    let id: String
    let groupName: String
    let email: String
}
