//
//  PasswordViewModelProtocol.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 06/07/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

protocol PasswordViewModelProtocol {
    var passwordsList: [PasswordDetails] {get}
    
    var passwordApiService: PasswordApiProtocol {get}
    
    init (passwordApiService: PasswordApiProtocol)
    
    func fetchUserPasswords()
}