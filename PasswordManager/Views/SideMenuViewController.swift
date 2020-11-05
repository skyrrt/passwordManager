//
//  SideMenuViewController.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 25/10/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit

enum MenuLabel: String, CaseIterable {
    case passwords = "Passwords"
    case groupPasswords = "Group passwords"
    case groups = "Groups"
    case appInfo = "App info"
    case signOut = "SignOut"
}

protocol SideMenuControllerDelegate {
    func didSelectMenuItem(withName: MenuLabel)
}

class SideMenuViewController: UITableViewController {
    let menuItems = MenuLabel.allCases
    var delegate: SideMenuControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .darkGray

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.textLabel?.backgroundColor = .darkGray
        cell.contentView.backgroundColor = .darkGray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(withName: selectedItem)
    }
}

 
