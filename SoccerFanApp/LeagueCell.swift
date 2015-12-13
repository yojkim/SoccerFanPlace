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
    @IBOutlet var countryImage: CountryImage!
    @IBOutlet var leagueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(name: String, countryImage: String?) {
        self.leagueLbl.text = name
        
        if let image = countryImage {
            self.countryImage.image = UIImage(named: image)
        }
    }

}
