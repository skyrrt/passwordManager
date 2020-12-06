//
//  SignInViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 09/07/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit
import FirebaseAuth
import LocalAuthentication

struct KeychainConfiguration {
  static let serviceName = "PasswordManager"
  static let accessGroup: String? = nil
}

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var signInViewModel: SignInViewModel?
    var passwordItems: [KeychainPasswordItem] = []
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    
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
        let hasLoginKey = UserDefaults.standard.bool(forKey: "hasLoginKey")
        if (hasLoginKey) {
            signIn(email: emailTextField.text ?? "", password: passwordTextField.text ?? "", faceId: false)
        } else {
        let ac = UIAlertController(title: "Do you want to enable Face Recognition?", message: nil, preferredStyle: .alert)

        let submitAction = UIAlertAction(title: "Yes", style: .default) { _ in
            self.signIn(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", faceId: true)
        }
        let dismissAction = UIAlertAction(title: "No", style: .default) { _ in
            self.signIn(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", faceId: false)
        }

        ac.addAction(submitAction)
        ac.addAction(dismissAction)

        present(ac, animated: true)
        }
        
    }
    @IBAction func signInUsingFaceRecognitionPressed(_ sender: Any) {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Identify yourself!"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                    [weak self] success, authenticationError in

                    DispatchQueue.main.async {
                        if success && UserDefaults.standard.bool(forKey: "hasLoginKey") {
                            let username = UserDefaults.standard.value(forKey: "username") as! String
                            do {
                                let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                                        account: username,
                                                                        accessGroup: KeychainConfiguration.accessGroup)
                                let keychainPassword = try passwordItem.readPassword()
                                self!.signIn(email: username, password: keychainPassword, faceId: false)
                              } catch {
                                fatalError("Error reading password from keychain - \(error)")
                              }
                        } else {
                            let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self?.present(ac, animated: true)
                        }
                    }
                }
            } else {
                let ac = UIAlertController(title: "FaceID unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
            }
        }
    
    func showAlert(withTitle: String, withMessage: String, withButtonTitle: String) {
        let alert = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: withButtonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func signIn(email: String, password: String, faceId: Bool) {
        signInViewModel?.authenticateUser(userName: email, password: password, enableFaceId: faceId) { (result) -> Void in
            if let error = result.get() as? Error {
                self.showAlert(withTitle: "Error", withMessage: error.localizedDescription, withButtonTitle: "OK")
                return
            }
            if case SignInResult.invalidInput = result {
                self.showAlert(withTitle: "Error", withMessage: "Invalid data", withButtonTitle: "OK")
            }
        }
    }
}
