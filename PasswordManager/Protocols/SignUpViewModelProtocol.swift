//
//  SignUpViewModelProtocol.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 27/09/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

protocol SignUpViewModelProtocol {
    func registerUser(userName: String?, password: String?, completion: @escaping (SignUpResult) -> ())
    func deleteUser()
}
