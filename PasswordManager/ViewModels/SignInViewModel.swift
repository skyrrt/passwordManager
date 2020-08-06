//
//  SignInViewModel.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 05/08/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation
import FirebaseAuth

class SignInViewModel {
    
    func authenticateUser(userName: String?, password: String?, completion: @escaping (SignInResult) -> Void) {
        guard
            let email = userName,
            let pass = password,
            email.count > 0,
            pass.count > 0
        else {
                completion(SignInResult.invalidInput)
                return
        }
            Auth.auth().signIn(withEmail: email, password: pass) { user, error in
                if let error = error, user == nil {
                    completion(SignInResult.loginError(error))
                }
            }
    
    }
}

enum SignInResult {
    case loginError(Error)
    case invalidInput
    case success
    
    func get() -> Any {
        switch self {
        case .loginError(let value):
            return value
        default:
            return self
        }
    }
}
