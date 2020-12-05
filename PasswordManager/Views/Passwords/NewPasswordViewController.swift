//
//  NewPasswordViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 11/08/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit
import DropDown
import Firebase

class NewPasswordViewController: UIViewController {
    
    @IBOutlet weak var passNameTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repPasswordTextFIeld: UITextField!
    @IBOutlet weak var groupNameLabel: UILabel!
    var selectedGroup: GroupDetails?
    var passwordViewModel: PasswordViewModel?
    var groupsViewModel: GroupsViewModel?
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.groupNameLabel.text = selectedGroup?.groupName ?? "Not Assigned"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func generatePressed(_ sender: UIButton) {
        let generatedPassword = randomString(length: 13)
        passwordTextField.text = generatedPassword
        repPasswordTextFIeld.text = generatedPassword
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        guard
            let passName = passNameTextField.text,
            let login = loginTextField.text,
            let pass = passwordTextField.text,
            let repPass = repPasswordTextFIeld.text,
            pass.count > 0,
            passName.count > 0,
            login.count > 0,
            pass == repPass
        else {
            let alert = UIAlertController(title: "Error", message: "Wrong input data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        let passwordDetails = PasswordDetails(id: nil, vendorName: passName, passwordHash: pass, userAccount: login, userId: Auth.auth().currentUser!.uid, groupId: selectedGroup?.id, groupName: nil)
        passwordViewModel?.createPassword(passwordDetails: passwordDetails) {
            self.passwordViewModel?.fetchPasswords()
        }
        
        dismiss(animated: false, completion: nil)
    }
    @IBAction func assignToGroupTapped(_ sender: UIButton) {
        var groups = groupsViewModel?.groupsCollection.value
        groups?.append(GroupDetails(id: nil, groupName: "Not assigned", createdBy: nil))
        let groupNames = groups!.map({$0.groupName})
        dropDown.dataSource = groupNames
            dropDown.anchorView = sender //5
            dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
            dropDown.show() //7
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
              guard let _ = self else { return }
                self?.groupNameLabel.text = item
                self?.selectedGroup = groups![index]
            }
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnprsquwxyzABCDEFGHIJKMNPLRSQUW,./;'[]<>?:|{}()0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
