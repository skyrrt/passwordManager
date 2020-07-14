//
//  SignInViewModel.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 13/07/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation
import FirebaseAuth

class SignUpViewModel {
    
    func registerUser(userName: String?, password: String?, completion: @escaping (SignUpResult) -> ()) {
        if let user = userName, let pass = password {
            print("User: \(user) pass:\(pass)")
            Auth.auth().createUser(withEmail: user, password: pass) { (authData, error) in
                if let e = error {
                     completion(SignUpResult.error(e))
                } else {
                    completion(SignUpResult.success(authData!))
                }
            }
        }
    }
}

enum SignUpResult {
    case success(AuthDataResult)
    case error(Error)
    
    func get() -> Any {
        switch self {
        case .error(let value):
            return value
        case .success(let value):
            return value
        }
    }
}