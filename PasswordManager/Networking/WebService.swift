//
//  WebService.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 27/09/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class WebService: WebServiceProtocol {
    
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    func createPassword(withName: String, password: String, login: String) {
        if let currentUser = user {
            
            let passwordDetails = PasswordDetails(vendorName: withName, passwordHash: password, userAccount: login, createdBy: currentUser.uid, groupId: nil)
            do {
                try db.collection("passwords").addDocument(from: passwordDetails) {
                    error in
                    if let e = error {
                        print("lipa \(e)")
                    }
                }
            } catch {
                print("error while saving")
            }
        }
    }
    
    func fetchPasswords(completion: @escaping ([PasswordDetails]) -> Void) {
        if let currentUser = user {
            db.collection("passwords").whereField("createdBy", isEqualTo: currentUser.uid)
                .getDocuments() { (querySnapshot, error) in
                    if let err = error {
                        print("lipa \(err)")
                    } else {
                        var passwords = [PasswordDetails]([])
                        for document in querySnapshot!.documents {
                            do {
                                passwords.append(try document.data(as: PasswordDetails.self)!)
                            } catch let error {
                                print("ERROR \(error)")
                                return
                            }
                        }
                        completion(passwords)
                    }
                }
        }
        
    }
    
    
}
