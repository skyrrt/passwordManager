//
//  GroupsTableViewCell.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 29/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit
import Firebase

class GroupsTableViewCell: UITableViewCell {
    
    var groupDetails: GroupDetails?
    var delegate: MyCustomCellDelegator!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var membersButton: UIButton!
    @IBOutlet weak var leaveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func membersButtonTapped(_ sender: UIButton) {
        if (self.delegate != nil) {
            self.delegate.callSegueFromCell(myData: groupDetails!.id)
        }
    }
    
    @IBAction func leaveButtonTapped(_ sender: UIButton) {
    }
    
}
