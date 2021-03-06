//
//  GroupMembersViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 29/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit
import RxSwift

class GroupMembersViewController: UITableViewController, ViewRefreshDelegate {
    
    @IBOutlet var usersTableView: UITableView!
    var usersViewModel: UserViewModel?
    let disposeBag = DisposeBag()
    var groupId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.dataSource = self
        usersViewModel = UserViewModel()
        usersViewModel?.groupUsersCollection.asObservable()
            .subscribe(onNext: {
                [weak self] _ in
                self?.repopulateView()
            }).disposed(by: disposeBag)
        usersViewModel?.fetchGroupUsers(groupId: groupId!)
    }
    
    @IBAction func refetchGoups(_ sender: UIRefreshControl) {
        self.usersViewModel?.fetchGroupUsers(groupId: groupId!)
        sender.endRefreshing()
    }
    
    func refreshView(groupId: String, userId: String) {
        usersViewModel?.deleteUserFromGroup(userId: userId, groupId: groupId) {
            self.usersViewModel?.fetchGroupUsers(groupId: groupId)
        }
    }
    
    func repopulateView() {
        DispatchQueue.main.async {
            self.usersTableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (usersViewModel?.groupUsersCollection.value.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserMembersCell", for: indexPath) as! UserMembersCell
        cell.groupId = groupId
        cell.user = usersViewModel?.groupUsersCollection.value[indexPath.row]
        cell.mailLabel.text = cell.user?.email
        cell.usersViewModel = self.usersViewModel
        cell.delegate = self
        return cell
    }
}

protocol ViewRefreshDelegate {
    func refreshView(groupId: String, userId: String)
}
