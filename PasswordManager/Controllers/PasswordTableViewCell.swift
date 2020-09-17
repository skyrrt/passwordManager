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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: "#6599FF")
        copyButton.layer.cornerRadius = 15
        copyButton.clipsToBounds = true
        detailsButton.layer.cornerRadius = 15
        detailsButton.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func copyTapped(_ sender: UIButton) {
    }
    
    @IBAction func detailsTapped(_ sender: UIButton) {
    }
    
}
