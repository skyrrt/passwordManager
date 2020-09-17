//
//  ViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 24/06/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit
import FirebaseAuth

class PasswordListViewController: UIViewController {

    @IBOutlet weak var passwordTableView: UITableView!
    var passwordViewModel: PasswordViewModel?
    var passwords: [PasswordDetails] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTableView.dataSource = self
        passwordViewModel = PasswordViewModel.init()
        passwords = passwordViewModel!.fetchPasswords()
    }

    @IBAction func signOutClicked(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
            
        } catch (let error) {
          print("Auth sign out failed: \(error)")
        }
    }
    @IBAction func addPasswordClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "createNewPasswordSegue", sender: nil)
    }
    
}

extension PasswordListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordTableViewCell", for: indexPath) as! PasswordTableViewCell
        cell.vendorNameLabel.text = passwords[indexPath.row].vendorName
        return cell
    }
    
    
}

