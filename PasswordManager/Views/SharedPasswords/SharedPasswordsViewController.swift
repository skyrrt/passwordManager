//
//  SharedPasswordsViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 05/12/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit
import RxSwift

class SharedPasswordsViewController: UITableViewController {
    @IBOutlet weak var passwordTableView: UITableView!
    var passwordViewModel: PasswordViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTableView.dataSource = self
        passwordViewModel = PasswordViewModel()
        passwordViewModel?.sharedPasswordCollection.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.repopulateView()
            }).disposed(by: disposeBag)
        passwordViewModel?.fetchGroupPasswords()
    }
    
    func repopulateView() {
        DispatchQueue.main.async {
            self.passwordTableView.reloadData()
        }
    }
    @IBAction func refreshPulled(_ sender: UIRefreshControl) {
        self.passwordViewModel?.fetchGroupPasswords()
        sender.endRefreshing()
    }
}

extension SharedPasswordsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (passwordViewModel?.sharedPasswordCollection.value.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SharedPasswordCell", for: indexPath) as! SharedPasswordCell
        cell.passwordDetails = passwordViewModel?.sharedPasswordCollection.value[indexPath.row]
        cell.vendorNameLabel.text = cell.passwordDetails?.vendorName
        return cell
    }
}
