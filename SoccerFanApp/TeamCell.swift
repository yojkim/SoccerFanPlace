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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(name: String) {
        self.teamLbl.text = name
    }
}
