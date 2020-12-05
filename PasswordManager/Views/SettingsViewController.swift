//
//  SettingsViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 13/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    var userViewModel: UserViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        userViewModel = UserViewModel()
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        signOut()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
            
        } catch (let error) {
            print("Auth sign out failed: \(error)")
        }
    }
    @IBAction func deleteAccountTapped(_ sender: UIButton) {
        self.userViewModel?.deleteUser()
        Auth.auth().currentUser?.delete(completion: {
            error in
            if error != nil {
                self.navigationController?.popToRootViewController(animated: true)
            }
        })
    }

}
