//
//  WebServiceProtocol.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 27/09/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

protocol WebServiceProtocol {
    
    func createPassword(withName: String, password: String, login: String, group: Group?)
    
    func fetchPasswords(completion: @escaping ([PasswordDetails], WSResult) -> Void)
    
}
