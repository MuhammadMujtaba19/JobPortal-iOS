//
//  headerCell.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/21/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import UIKit


class headerCell:UITableViewCell{
    @IBOutlet weak var SectionTitle: UILabel!
    
    @IBOutlet weak var sectionButton: UIButton!
    
    var subscribeButtonAction : (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.sectionButton.addTarget(self, action: #selector(ButtonTapped(_:)), for: .touchUpInside)

    }
    @IBAction func ButtonTapped(_ sender: UIButton){
      // if the closure is defined (not nil)
      // then execute the code inside the subscribeButtonAction closure
      subscribeButtonAction?()
    }
    
}

