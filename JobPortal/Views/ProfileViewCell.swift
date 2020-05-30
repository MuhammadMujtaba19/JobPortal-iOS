//
//  ProfileViewCell.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/20/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
