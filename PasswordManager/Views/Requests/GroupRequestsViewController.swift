//
//  GroupRequestsTableView.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 01/12/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit
import RxSwift

class GroupRequestsViewController: UITableViewController, GroupRequestsDelegate {
    
    var groupsViewModel: GroupsViewModel?
    let disposeBag = DisposeBag()
    @IBOutlet var groupRequestsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupRequestsTableView.dataSource = self
        groupsViewModel = GroupsViewModel()
        groupsViewModel?.groupRequests.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.repopulateView()
            }).disposed(by: disposeBag)
        groupsViewModel?.fetchGroupRequests()
    }
    
    @IBAction func refetchData(_ sender: UIRefreshControl) {
        self.groupsViewModel?.fetchGroupRequests()
        sender.endRefreshing()
    }
    
    func answerRequest(requestId: String, accepted: Bool) {
        groupsViewModel?.answerRequest(requestId: requestId, accepted: accepted) {
            self.groupsViewModel?.fetchGroupRequests()
        }
    }
    
    func repopulateView() {
        DispatchQueue.main.async {
            self.groupRequestsTableView.reloadData()
        }
    }
}

extension GroupRequestsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (groupsViewModel?.groupRequests.value.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupRequestCell", for: indexPath) as! GroupRequestCell
        cell.delegate = self
        cell.groupRequestDetails = groupsViewModel?.groupRequests.value[indexPath.row]
        cell.groupNameLabel.text = cell.groupRequestDetails?.groupName
        cell.userMailLabel.text = cell.groupRequestDetails?.email
        return cell
    }
}

protocol GroupRequestsDelegate {
    func answerRequest(requestId: String, accepted: Bool)
}
