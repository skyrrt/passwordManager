//
//  PasswordTableViewCell.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 05/07/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit

class PasswordTableViewCell: UITableViewCell {

    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    let pasteboard = UIPasteboard.general
    var delegate: SegueExecutorDelegate?
    var passwordDetails: PasswordDetails?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: "#6598ff")
        copyButton.layer.cornerRadius = 15
        copyButton.clipsToBounds = true
        detailsButton.layer.cornerRadius = 15
        detailsButton.clipsToBounds = true        
    }

    @IBAction func copyTapped(_ sender: UIButton) {
        pasteboard.string = passwordDetails!.passwordHash
    }
    
    @IBAction func detailsTapped(_ sender: UIButton) {
        delegate?.triggerSegue(passwordDto: passwordDetails!)
    }
    
}
