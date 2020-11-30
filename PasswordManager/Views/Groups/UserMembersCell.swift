//
//  UserMembersCell.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 29/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit

class UserMembersCell: UITableViewCell {
    
    @IBOutlet weak var mailLabel: UILabel!
    var groupId: String?
    var user: UserDetails?
    var usersViewModel: UserViewModel?
    var delegate: ViewRefreshDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func deleteUserTapped(_ sender: UIButton) {
        usersViewModel?.deleteUserFromGroup(userId: user!.id, groupId: groupId!)
        delegate?.refreshView()
        
    }
}
