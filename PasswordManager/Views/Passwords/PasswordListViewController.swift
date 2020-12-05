//
//  ViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 24/06/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit
import RxSwift
import FirebaseAuth

class PasswordListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SegueExecutorDelegate {
    
    @IBOutlet weak var passwordTableView: UITableView!
    @IBOutlet weak var plusButton: UIBarButtonItem!
    var passwordViewModel: PasswordViewModel?
    var groupsViewModel: GroupsViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTableView.dataSource = self
        passwordTableView.delegate = self
        passwordViewModel = PasswordViewModel()
        groupsViewModel = GroupsViewModel()
        passwordViewModel?.passwordCollection.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.repopulateView()
            }).disposed(by: disposeBag)
        passwordViewModel?.fetchPasswords()
        groupsViewModel?.fetchGroups()
        
    }
    
    @IBAction func addPasswordClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "createNewPasswordSegue", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.passwordViewModel?.fetchPasswords()
        self.groupsViewModel?.fetchGroups()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNewPasswordSegue" {
            if let viewController = segue.destination as? NewPasswordViewController {
                viewController.passwordViewModel = self.passwordViewModel
                viewController.groupsViewModel = self.groupsViewModel
            }
        } else if segue.identifier == "showDetailsSegue" { //TODO: REFACTOR hardcoded values
            if let viewController = segue.destination as? PasswordDetailsViewController {
                viewController.passwordViewModel = self.passwordViewModel
                viewController.passwordDetails = sender as? PasswordDetails
            }
        } else if segue.identifier == "editPasswordSegue" {
            if let viewController = segue.destination as? ModifyPasswordViewController {
                viewController.passwordViewModel = self.passwordViewModel
                viewController.groupsViewModel = self.groupsViewModel
                viewController.password = sender as? PasswordDetails
            }
        }
    }
    
    func repopulateView() {
        DispatchQueue.main.async {
            self.passwordTableView.reloadData()
            self.groupsViewModel?.fetchGroups()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            guard let passwordItem = passwordViewModel?.passwordCollection.value[indexPath.row] else { return }
            passwordViewModel?.deletePassword(passwordDto: passwordItem) {
                self.passwordViewModel?.fetchPasswords()
            }
            
        }
    }
    
    func triggerSegue(passwordDto: PasswordDetails) {
        performSegue(withIdentifier: "editPasswordSegue", sender: passwordDto)
    }

    
}

extension PasswordListViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (passwordViewModel?.passwordCollection.value.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordTableViewCell", for: indexPath) as! PasswordTableViewCell
        cell.passwordDetails = passwordViewModel?.passwordCollection.value[indexPath.row]
        cell.vendorNameLabel.text = cell.passwordDetails?.vendorName
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "showDetailsSegue", sender: passwordViewModel?.passwordCollection.value[indexPath.row])
    }
}

protocol SegueExecutorDelegate {
    func triggerSegue(passwordDto: PasswordDetails)
}
