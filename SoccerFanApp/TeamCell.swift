//
//  TeamCell.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2015. 12. 13..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {
    
    @IBOutlet var teamLbl: UILabel!
    @IBOutlet var checkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(name: String, checked: Bool) {
        self.teamLbl.text = name
        
        if checked {
            checkImage.hidden = false
            checkImage.image = UIImage(named: "Check")
        } else {
            checkImage.hidden = true
        }
    }
}
