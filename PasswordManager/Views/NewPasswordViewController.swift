//
//  NewPasswordViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 11/08/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    @IBOutlet weak var passNameTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repPasswordTextFIeld: UITextField!
    var passwordViewModel: PasswordViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordViewModel = PasswordViewModel.init(webService: WebService())
    }
    

    
    @IBAction func generatePressed(_ sender: UIButton) {
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        guard
            let passName = passwordTextField.text,
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
        passwordViewModel?.createPassword(withName: passName, password: pass, login: login)
    }
    
}
