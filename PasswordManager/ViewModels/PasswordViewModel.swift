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
    var webService: WebServiceProtocol
    
    required init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func createPassword(withName name: String, password: String, login: String, group: Group?) {
        webService.createPassword(withName: name, password: password, login: login, group: group)
    }
    
    func fetchGroupPasswords() {
        passwordCollection.accept([])
    }
    
    func fetchPasswords() throws -> Void {
        webService.fetchPasswords(completion: {
            passwords, result in
            switch(result) {
            case .success:
                self.passwordCollection.accept(passwords)
            case .error:
                throw FetchError.error
            }
            
        })
    }
}
