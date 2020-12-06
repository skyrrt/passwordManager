//
//  SignInViewModel.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 05/08/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation
import FirebaseAuth

class SignInViewModel: SignInViewModelProtocol {
    
    func authenticateUser(userName: String?, password: String?, enableFaceId: Bool, completion: @escaping (SignInResult) -> Void) {
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
                if (enableFaceId) {
                let hasLoginKey = UserDefaults.standard.bool(forKey: "hasLoginKey")
                if (!hasLoginKey) {
                    UserDefaults.standard.setValue(email, forKey: "username")
                }
                      
                    // 5
                    do {
                      // This is a new account, create a new keychain item with the account name.
                      let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                              account: email,
                                                              accessGroup: KeychainConfiguration.accessGroup)
                        
                      // Save the password for the new item.
                      try passwordItem.savePassword(pass)
                    } catch {
                      fatalError("Error updating keychain - \(error)")
                    }
                      
                    // 6
                    UserDefaults.standard.set(true, forKey: "hasLoginKey")
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
