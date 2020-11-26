//
//  PasswordViewModel.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 18/08/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

enum FetchError: Error {
    case error
}

class PasswordViewModel: PasswordViewModelProtocol {
    
    var passwordCollection = BehaviorRelay<[PasswordDetails]>(value: [PasswordDetails]())
    var webService = PasswordApiService()
    
    
    func createPassword(passwordDetails: PasswordDetails) {
        webService.postNewPassword(password: passwordDetails)
    }
    
    func fetchGroupPasswords() {
    }
    
    func fetchPasswords() -> Void {
        webService.fetchMyPasswords(completion: {
            passwords in self.passwordCollection.accept(passwords)
        })
    }
}
