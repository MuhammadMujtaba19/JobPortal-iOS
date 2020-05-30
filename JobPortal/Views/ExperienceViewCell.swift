//
//  ExperienceViewCell.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/21/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import UIKit

class ExperienceViewCell: UITableViewCell {
 @IBOutlet weak var JobDesignation: UILabel!
    
@IBOutlet weak var JobDescription: UILabel!
    
    @IBOutlet weak var dates:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
