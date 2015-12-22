//
//  MatchCell.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2015. 12. 21..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit

class MatchCell: UITableViewCell {
    
    @IBOutlet var timeResultLabel: UILabel!
    @IBOutlet var statusImage: UIImageView!
    @IBOutlet var homeTeamLabel: UILabel!
    @IBOutlet var awayTeamLabel: UILabel!
    @IBOutlet var homeTeamScore: UILabel!
    @IBOutlet var awayTeamScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(time: String?, matchResult: Int?, matchStatus: String, home: String, away: String, homeScore: String?, awayScore: String?) {
        
        self.timeResultLabel.text = time
        self.homeTeamLabel.text = home
        self.awayTeamLabel.text = away
        
        // ready for match status
        if matchStatus == "ready" {
            self.statusImage.hidden = true
        }
        
        // playing for match now
        else if matchStatus == "now" {
            self.statusImage.image = UIImage(named: "matchNow")
            
            setScoreLabel(homeScore!, away: awayScore!)
        }
        
        // match ended
        else {
            self.statusImage.image = UIImage(named: "matchEnd")
            setScoreLabel(homeScore!, away: awayScore!)
        }
        
    }
    
    func setScoreLabel(home: String, away: String) {
        if home > away {
            self.homeTeamScore.textColor = UIColor.redColor()
            self.awayTeamLabel.textColor = UIColor.blackColor()
            
        } else if home < away {
            self.homeTeamScore.textColor = UIColor.blackColor()
            self.awayTeamLabel.textColor = UIColor.redColor()
        } else {
            self.homeTeamScore.textColor = UIColor.blackColor()
            self.awayTeamLabel.textColor = UIColor.blackColor()
        }
        
        self.homeTeamScore.text = "\(home)"
        self.awayTeamLabel.text = "\(away)"
    }

}
