//
//  NewGroupViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 15/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit

class NewGroupViewController: UIViewController {
    
    var groupsViewModel: GroupsViewModel?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text,
              let description = descriptionTextField.text
        else {
            let alert = UIAlertController(title: "Error", message: "Wrong input data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        groupsViewModel?.createGroup(group: Group(id: nil, name: name, description: description))
        groupsViewModel?.fetchGroups()
        dismiss(animated: true, completion: nil)
    }
}
