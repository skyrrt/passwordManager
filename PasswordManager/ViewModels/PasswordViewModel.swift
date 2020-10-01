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


class PasswordViewModel: PasswordViewModelProtocol {
    
    var passwordCollection = BehaviorRelay<[PasswordDetails]>(value: [PasswordDetails]())
    var webService: WebServiceProtocol
    
    required init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func createPassword(withName name: String, password: String, login: String) {
        webService.createPassword(withName: name, password: password, login: login)
    }
    
    func fetchPasswords() {
        webService.fetchPasswords(completion: {
            passwords in self.passwordCollection.accept(passwords)
        })
    }
}
