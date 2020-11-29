//
//  SignInViewModel.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 13/07/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation
import FirebaseAuth

class SignUpViewModel: SignUpViewModelProtocol {
    
    var webService = UserApiService()
    
    func registerUser(userName: String?, password: String?, completion: @escaping (SignUpResult) -> ()) {
        if let user = userName, let pass = password {
            Auth.auth().createUser(withEmail: user, password: pass) { (authData, error) in
                if let e = error {
                     completion(SignUpResult.error(e))
                } else {
                    self.webService.postNewUser(user: UserDto(uid: authData!.user.uid, email: user)) {
                        Auth.auth().signIn(withEmail: user, password: pass)
                    }
                    
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
