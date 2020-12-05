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
    
    @IBAction func addGroupAdded(_ sender: UIButton) {
        promptForAnswer()
    }
    
    @IBAction func joinTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "qrCodeScannerSegue", sender: nil)
    }
    
    func foundCodeHandler(groupId: String) {
        print(groupId)
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
        } else if segue.identifier == "qrCodeScannerSegue" {
            if let viewController = segue.destination as? ScannerViewController {
                viewController.delegate = self
            }
        }
    }
    
    @IBAction func refreshGroupsPulled(_ sender: UIRefreshControl) {
        self.groupsViewModel?.fetchGroups()
        sender.endRefreshing()
    }
    
    
    func promptForAnswer() {
        let ac = UIAlertController(title: "Enter group name", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Create", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0].text
            self.groupsViewModel?.createGroup(group: Group(groupName: answer!, createdBy: Auth.auth().currentUser!.uid)) {
                self.groupsViewModel?.fetchGroups()
            }
            
        }
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default)

        ac.addAction(submitAction)
        ac.addAction(dismissAction)

        present(ac, animated: true)
    }
    
    func navigateToMembers(myData dataobject: Any) {
        self.performSegue(withIdentifier: "GroupMembersSegue", sender: dataobject)
    }
    
    func leaveGroup(groupId: String) {
        groupsViewModel?.leaveGroup(groupId: groupId) {
            self.groupsViewModel?.fetchGroups()
        }
    }
    
    func showGroupInvitation(groupId: String) {
        let image = generateQRCode(from: groupId)
        let imageView = UIImageView(frame: CGRect(x: 10, y: 50, width: 250, height: 230))
        imageView.image = image
        let ac = UIAlertController(title: "Scan code", message: nil, preferredStyle: .alert)
        ac.view.addSubview(imageView)
        let height = NSLayoutConstraint(item: ac.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 340)
        ac.view.addConstraint(height)
        let dismissAction = UIAlertAction(title: "OK", style: .default)

        ac.addAction(dismissAction)

        present(ac, animated: true)
        
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.utf8)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
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
    func navigateToMembers(myData dataobject: Any)
    func leaveGroup(groupId: String)
    func showGroupInvitation(groupId: String)
    func foundCodeHandler(groupId: String)
}
