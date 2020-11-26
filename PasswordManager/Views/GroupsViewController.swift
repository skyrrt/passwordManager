//
//  GroupsViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 02/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit

class GroupsViewController: UITableViewController {
    
    var groupsViewModel: GroupsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func addGroupAdded(_ sender: Any) {
        self.performSegue(withIdentifier: "NewGroupSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewGroupSegue" {
            if let viewController = segue.destination as? NewGroupViewController {
                viewController.groupsViewModel = self.groupsViewModel
            }
        }
    }
    

}
