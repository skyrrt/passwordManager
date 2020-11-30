//
//  GroupsViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 02/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit
import RxSwift
import Firebase

class GroupsViewController: UITableViewController, MyCustomCellDelegator {
    
    var groupsViewModel: GroupsViewModel?
    let disposeBag = DisposeBag()
    @IBOutlet var groupsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.dataSource = self
        groupsViewModel = GroupsViewModel()
        groupsViewModel?.groupsCollection.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.repopulateView()
            }).disposed(by: disposeBag)
        groupsViewModel?.fetchGroups()
    }
    
    @IBAction func addGroupAdded(_ sender: Any) {
        promptForAnswer()
    }
    
    func repopulateView() {
        DispatchQueue.main.async {
            self.groupsTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GroupMembersSegue" {
            if let viewController = segue.destination as? GroupMembersViewController {
                viewController.groupId = sender as? String
            }
        }
    }
    
    
    func promptForAnswer() {
        let ac = UIAlertController(title: "Enter group name", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Create", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0].text
            self.groupsViewModel?.createGroup(group: Group(groupName: answer!, createdBy: Auth.auth().currentUser!.uid))
            self.groupsViewModel?.fetchGroups()
        }
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default)

        ac.addAction(submitAction)
        ac.addAction(dismissAction)

        present(ac, animated: true)
    }
    
    func callSegueFromCell(myData dataobject: Any) {
        self.performSegue(withIdentifier: "GroupMembersSegue", sender: dataobject)
    }
    
}

extension GroupsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (groupsViewModel?.groupsCollection.value.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupsTableViewCell
        cell.groupDetails = groupsViewModel?.groupsCollection.value[indexPath.row]
        cell.groupName.text = cell.groupDetails?.groupName
        if (Auth.auth().currentUser!.uid != cell.groupDetails?.createdBy) {
            cell.membersButton.isEnabled = false
        }
        cell.delegate = self
        return cell
    }
}

protocol MyCustomCellDelegator {
    func callSegueFromCell(myData dataobject: Any)
}
