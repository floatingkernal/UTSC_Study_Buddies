//
//  CustomTableViewCell.swift
//  UTSC_Study_Buddies
//
//  Created by Salman Sharif on 2017-02-25.
//  Copyright © 2017 Salman Sharif. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var ccode: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
