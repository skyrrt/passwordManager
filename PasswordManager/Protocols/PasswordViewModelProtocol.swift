//
//  PasswordViewModelProtocl.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 27/09/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol PasswordViewModelProtocol {
    
    var passwordCollection: BehaviorRelay<[PasswordDetails]> {get}
    
    func fetchPasswords() -> Void
    
    func fetchGroupPasswords() -> Void
    
    func createPassword(passwordDetails: PasswordDetails)
}
