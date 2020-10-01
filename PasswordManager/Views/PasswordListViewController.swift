//
//  ViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 24/06/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit
import FirebaseAuth
import RxSwift

class PasswordListViewController: UIViewController {

    @IBOutlet weak var passwordTableView: UITableView!
    
    var passwordViewModel: PasswordViewModelProtocol?
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTableView.dataSource = self
        passwordViewModel = PasswordViewModel(webService: WebService())
        passwordViewModel?.passwordCollection.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.repopulateView()
            }).disposed(by: disposeBag)
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
    
    func repopulateView() {
        self.passwordTableView.reloadData()
    }
    
}

extension PasswordListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (passwordViewModel?.passwordCollection.value.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordTableViewCell", for: indexPath) as! PasswordTableViewCell
        cell.vendorNameLabel.text = passwordViewModel?.passwordCollection.value[indexPath.row].vendorName
        return cell
    }
    
    
}

