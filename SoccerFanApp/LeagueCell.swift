//
//  LeagueCell.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2015. 12. 9..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit

class LeagueCell: UITableViewCell {
    
    @IBOutlet var starImage: UIImageView!
    @IBOutlet var leagueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(name: String) {
        self.leagueLbl.text = name
    }

}
