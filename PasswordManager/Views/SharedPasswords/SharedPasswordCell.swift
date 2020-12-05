//
//  SharedPasswordCell.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 05/12/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import UIKit

class SharedPasswordCell: UITableViewCell {
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    let pasteboard = UIPasteboard.general
    var passwordDetails: PasswordDetails?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: "#6598ff")
        copyButton.layer.cornerRadius = 15
        copyButton.clipsToBounds = true
    }

    @IBAction func copyTapped(_ sender: UIButton) {
        pasteboard.string = passwordDetails!.passwordHash
    }
}
