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

class PasswordListViewController: UIViewController {
    
    @IBOutlet weak var passwordTableView: UITableView!
    @IBOutlet weak var plusButton: UIBarButtonItem!
    var passwordViewModel: PasswordViewModelProtocol?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTableView.dataSource = self
        passwordViewModel = PasswordViewModel()
        passwordViewModel?.passwordCollection.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.repopulateView()
            }).disposed(by: disposeBag)
        passwordViewModel?.fetchPasswords()
        
    }
    
    @IBAction func addPasswordClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "createNewPasswordSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNewPasswordSegue" {
            if let viewController = segue.destination as? NewPasswordViewController {
                viewController.passwordViewModel = self.passwordViewModel
            }
        }
    }
    
    func repopulateView() {
        DispatchQueue.main.async {
            self.passwordTableView.reloadData()
        }
    }
    
}

extension PasswordListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (passwordViewModel?.passwordCollection.value.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordTableViewCell", for: indexPath) as! PasswordTableViewCell
        cell.passwordDetails = passwordViewModel?.passwordCollection.value[indexPath.row]
        cell.vendorNameLabel.text = cell.passwordDetails?.vendorName
        return cell
    }
    
}
