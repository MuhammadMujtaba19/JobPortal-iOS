//
//  ProjectViewCell.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/21/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import UIKit

class ProjectViewCell: UITableViewCell {
    @IBOutlet weak var ProjectName: UILabel!
    @IBOutlet weak var GithubLink: UILabel!
    @IBOutlet weak var FrameworkName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
