//
//  SignUpViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 09/07/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var signUpViewModel: SignUpViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpViewModel = SignUpViewModel.init()
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        signUpViewModel!.registerUser(userName: emailTextField.text, password: passwordTextField.text) { (result) -> () in
                
            if let error = result.get() as? Error {
                self.showAlert(withTitle: "Error", withMessage: error.localizedDescription, withButtonTitle: "OK")
            } else if let authResult = result.get() as? AuthDataResult {
                self.showAlert(withTitle: "OK", withMessage: "OK", withButtonTitle: "OK")
            }
                
        }
        
    }
    
    func showAlert(withTitle: String, withMessage: String, withButtonTitle: String) {
        let alert = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: withButtonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
