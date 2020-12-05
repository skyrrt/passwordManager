//
//  GroupRequestCell.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 02/12/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit

class GroupRequestCell: UITableViewCell {
    
    var groupRequestDetails: GroupRequestDetails?
    var delegate: GroupRequestsDelegate!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var userMailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func acceptanceTapped(_ sender: UIButton) {
        delegate.answerRequest(requestId: groupRequestDetails!.id, accepted: true)
    }
    @IBAction func rejectedTapped(_ sender: UIButton) {
        delegate.answerRequest(requestId: groupRequestDetails!.id, accepted: true)
    }
}
