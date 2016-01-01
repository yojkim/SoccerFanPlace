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
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var leagueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(time: String?, matchResult: Int?, matchStatus: String, home: String, away: String, homeScore: Int?, awayScore: Int?, date: String, leagueName: String) {
        
        self.timeResultLabel.text = time
        self.homeTeamLabel.text = home
        self.awayTeamLabel.text = away
        
        self.dateLabel.text = date
        self.leagueLabel.text = leagueName
        
        if home == DataServices.ds.supportTeam {
            self.homeTeamLabel.font = UIFont(name: "NanumBarunpen-Bold", size: 17.0)
            self.awayTeamLabel.font = UIFont(name: "NanumBarunpen", size: 17.0)
        } else {
            self.homeTeamLabel.font = UIFont(name: "NanumBarunpen", size: 17.0)
            self.awayTeamLabel.font = UIFont(name: "NanumBarunpen-Bold", size: 17.0)
        }
        
        // ready for match status
        if matchStatus == "ready" {
            self.timeResultLabel.textColor = UIColor.blackColor()
            self.homeTeamScore.hidden = true
            self.awayTeamScore.hidden = true
            self.statusImage.hidden = true
        }
        
        // playing for match now
        else if matchStatus == "now" {
            self.homeTeamScore.hidden = false
            self.awayTeamScore.hidden = false
            self.statusImage.hidden = false
            self.statusImage.image = UIImage(named: "matchNow")
            
            setScoreLabel(homeScore!, away: awayScore!)
        }
        
        // match ended
        else {
            self.homeTeamScore.hidden = false
            self.awayTeamScore.hidden = false
            self.statusImage.hidden = false
            self.statusImage.image = UIImage(named: "matchEnd")
            setScoreLabel(homeScore!, away: awayScore!)
            
            switch(matchResult!) {
            case 0:
                self.timeResultLabel.text = "승리"
                self.timeResultLabel.textColor = UIColor.blueColor()
            case 1:
                self.timeResultLabel.text = "무승부"
                self.timeResultLabel.textColor = UIColor.grayColor()
            case 2:
                self.timeResultLabel.text = "패배"
                self.timeResultLabel.textColor = UIColor.redColor()
            default: break
            }
        }
        
    }
    
    func setScoreLabel(home: Int, away: Int) {
        if home > away {
            self.homeTeamScore.textColor = UIColor.redColor()
            self.awayTeamScore.textColor = UIColor.blackColor()
            
        } else if home < away {
            self.homeTeamScore.textColor = UIColor.blackColor()
            self.awayTeamScore.textColor = UIColor.redColor()
        } else {
            self.homeTeamScore.textColor = UIColor.blackColor()
            self.awayTeamScore.textColor = UIColor.blackColor()
        }
        
        self.homeTeamScore.text = "\(home)"
        self.awayTeamScore.text = "\(away)"
    }

}
