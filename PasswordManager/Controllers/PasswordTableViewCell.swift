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
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: "#6599FF")
        
        
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
