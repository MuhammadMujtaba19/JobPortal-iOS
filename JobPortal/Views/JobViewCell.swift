//
//  JobViewCell.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/28/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import UIKit

class JobViewCell: UITableViewCell {

    @IBOutlet weak var JobTitle: UILabel!
    @IBOutlet weak var JobCompany: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
