//
//  PasswordViewModel.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 18/08/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class PasswordViewModel {
    
    let db = Firestore.firestore()
    var passwords: [PasswordDetails] = []
    func createPassword(withName: String, password: String, login: String) {
        if let currentUser = Auth.auth().currentUser {
            
            let passwordDetails = PasswordDetails(vendorName: withName, passwordHash: password, userAccount: login, createdBy: currentUser.uid, groupId: nil)
            db.collection("passwords").addDocument(data: passwordDetails.toAnyObject()) {
                (error) in
                if let e = error {
                    print("lipa \(e)")
                } else {
                    self.passwords.append(passwordDetails)
                }
            }
        }
    }
    
    func fetchPasswords() -> [PasswordDetails] {
        return passwords
    }
}
