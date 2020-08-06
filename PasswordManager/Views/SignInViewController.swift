//
//  SignInViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 09/07/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var signInViewModel: SignInViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInViewModel = SignInViewModel.init()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "LoginToList", sender: nil)
                self.emailTextField.text = nil
                self.passwordTextField.text = nil
            }
        }
        
    }
    @IBAction func signInPressed(_ sender: Any) {
        signInViewModel?.authenticateUser(userName: emailTextField.text, password: passwordTextField.text) { (result) -> Void in
            if let error = result.get() as? Error {
                self.showAlert(withTitle: "Error", withMessage: error.localizedDescription, withButtonTitle: "OK")
                return
            }
            if case SignInResult.invalidInput = result {
                self.showAlert(withTitle: "Error", withMessage: "Invalid data", withButtonTitle: "OK")
            }
        }
    }
    @IBAction func signInUsingFaceRecognitionPressed(_ sender: Any) {
    }
    
    func showAlert(withTitle: String, withMessage: String, withButtonTitle: String) {
        let alert = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: withButtonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
