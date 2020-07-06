//
//  PasswordDetails.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 05/07/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

class PasswordDetails {
    let vendorName: String?
    let passwordHash: String?
    let userAccount: String?
    let decryptedPassword: String?
    
    init(vendorName: String, passwordHash: String, userAccount: String, decryptedPassword: String){
        self.vendorName = vendorName
        self.passwordHash = passwordHash
        self.userAccount = userAccount
        self.decryptedPassword = decryptedPassword
    }
    
}
