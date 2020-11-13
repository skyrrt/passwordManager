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

enum WSResult {
    case error
    case success
}

class WebService: WebServiceProtocol {
    
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    func createPassword(withName: String, password: String, login: String, group: Group?) {
        if let currentUser = user {
            
            let passwordDetails = PasswordDetails(vendorName: withName, passwordHash: password, userAccount: login, createdBy: currentUser.uid, groupId: group?.id ?? nil)
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
    
    func fetchPasswords(completion: @escaping ([PasswordDetails], WSError) -> Void) {
        if let currentUser = user {
            db.collection("passwords")
                .whereField("createdBy", isEqualTo: currentUser.uid)
                .getDocuments() { (querySnapshot, error) in
                    if let err = error {
                        completion([], WSResult.error)
                    } else {
                        var passwords = [PasswordDetails]([])
                        for document in querySnapshot!.documents {
                            do {
                                passwords.append(try document.data(as: PasswordDetails.self)!)
                            } catch let error {
                                completion([], WSResult.error)
                            }
                        }
                        passwords = passwords.filter({$0.groupId == nil})
                        completion(passwords, WSResult.success)
                    }
                }
        }
        
    }
    
    func fetchGroupPasswords(groupIds: [String], completion: @escaping ([PasswordDetails], WSResult) -> Void) {
            db.collection("passwords")
                .whereField("groupId", in: groupIds)
                .getDocuments() { (querySnapshot, error) in
                    if error != nil {
                        completion([], WSResult.error)
                    } else {
                        var passwords = [PasswordDetails]([])
                        for document in querySnapshot!.documents {
                            do {
                                passwords.append(try document.data(as: PasswordDetails.self)!)
                            } catch _ {
                                completion([], WSResult.error)
                            }
                        }
                        completion(passwords, WSResult.success)
                    }
                }
        }
    
}
