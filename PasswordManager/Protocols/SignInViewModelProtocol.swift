//
//  SignInViewModelProtocol.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 27/09/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

protocol SignInViewModelProtocol {
    func authenticateUser(userName: String?, password: String?, enableFaceId: Bool, completion: @escaping (SignInResult) -> Void)
}
