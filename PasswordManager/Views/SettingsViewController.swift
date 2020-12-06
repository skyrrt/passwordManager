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
    @IBAction func disableFaceRecognition(_ sender: Any) {
        let hasLoginKey = UserDefaults.standard.bool(forKey: "hasLoginKey")
        if (hasLoginKey) {
            let savedEmail = UserDefaults.standard.value(forKey: "username") as? String
            if (Auth.auth().currentUser?.email == savedEmail) {
                let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                        account: savedEmail!,
                                                        accessGroup: KeychainConfiguration.accessGroup)
                UserDefaults.standard.setValue(nil, forKey: "username")
                UserDefaults.standard.setValue(false, forKey: "hasLoginKey")
                try! passwordItem.deleteItem()
            } else {
                showAlert(withTitle: "Error", withMessage: "You're not allowed to do that.", withButtonTitle: "OK")
            }
        } else {
            showAlert(withTitle: "Error", withMessage: "You're not allowed to do that.", withButtonTitle: "OK")
        }
        showAlert(withTitle: "Success", withMessage: "Face recognition successfully disabled.", withButtonTitle: "OK")
    }
    
    func showAlert(withTitle: String, withMessage: String, withButtonTitle: String) {
        let alert = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: withButtonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
