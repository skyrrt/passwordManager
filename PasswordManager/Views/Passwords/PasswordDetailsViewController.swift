//
//  PasswordDetailsViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 04/12/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit

class PasswordDetailsViewController: UIViewController {
    
    var passwordViewModel: PasswordViewModel?
    var passwordDetails: PasswordDetails?
    @IBOutlet weak var passwordLabelTextLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var passwordValueLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordValueLabel.isSecureTextEntry = true
        passwordValueLabel.isEnabled = false
        passwordLabelTextLabel.text = self.passwordDetails?.vendorName
        accountLabel.text = self.passwordDetails?.userAccount
        passwordValueLabel.text = self.passwordDetails?.passwordHash
        groupNameLabel.text = self.passwordDetails?.groupName ?? "Not assigned"
    }
    
    @IBAction func changePasswordVisibility(_ sender: UIButton) {
        passwordValueLabel.isSecureTextEntry = !passwordValueLabel.isSecureTextEntry
    }
}
