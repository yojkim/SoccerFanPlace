//
//  MainViewController.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2015. 12. 8..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit
import Kanna

class MainViewController: UIViewController {
    
    @IBOutlet var rankLable: UILabel!
    @IBOutlet var leagueLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var homeLabel: UILabel!
    @IBOutlet var awayLabel: UILabel!
    @IBOutlet var homeScoreLabel: UILabel!
    @IBOutlet var awayScoreLabel: UILabel!
    
    var matchData = MatchData()

    var urlString = "\(DataServices.ds.supportTeamURL)/statistics"
    var htmlString: NSString?
    var supportTeamRank: String?
    
    var startPoint: Int!
    var skipCount: Int!

    override func viewDidLoad() {
        self.loadRankData()
        
        startPoint = DataServices.ds.searchStartPoint
        skipCount = DataServices.ds.skipCount
        
        self.matchData.startPoint = self.startPoint
        self.matchData.skipCount = self.skipCount

        self.matchData.loadMatchData(startPoint, end: startPoint+(5+self.skipCount))
        
        super.viewDidLoad()
        self.receiveData()
    }
    
    override func viewDidAppear(animated: Bool) {
        urlString = "\(DataServices.ds.supportTeamURL)/statistics"
        self.loadRankData()
        
        startPoint = DataServices.ds.searchStartPoint
        skipCount = DataServices.ds.skipCount
        
        self.matchData.startPoint = self.startPoint
        self.matchData.skipCount = self.skipCount
        
        self.matchData.loadMatchData(startPoint, end: startPoint+(5+self.skipCount))
        super.viewDidAppear(true)
        
        self.receiveData()
    }
    
    func receiveData() {
        
        let home = self.matchData.recentHomeScore
        let away = self.matchData.recentAwayScore
        print(home)
        print(away)
        
        self.rankLable.text = self.supportTeamRank
        self.leagueLabel.text = self.matchData.recentLeague
        self.homeLabel.text = self.matchData.recentHomeTeam
        self.awayLabel.text = self.matchData.recentAwayTeam
        self.homeScoreLabel.text = self.matchData.recentHomeScore
        self.awayScoreLabel.text = self.matchData.recentAwayScore
        
        if home > away {
            self.homeScoreLabel.textColor = UIColor.redColor()
            self.awayScoreLabel.textColor = UIColor.blackColor()
            
        } else if home < away {
            self.homeScoreLabel.textColor = UIColor.blackColor()
            self.awayScoreLabel.textColor = UIColor.redColor()
        } else {
            self.homeScoreLabel.textColor = UIColor.blackColor()
            self.awayScoreLabel.textColor = UIColor.blackColor()
        }
        
        switch(self.matchData.recentMatchResult) {
        case 0:
            self.resultLabel.text = "승리"
            self.resultLabel.textColor = UIColor.blueColor()
        case 1:
            self.resultLabel.text = "무승부"
            self.resultLabel.textColor = UIColor.grayColor()
        case 2:
            self.resultLabel.text = "패배"
            self.resultLabel.textColor = UIColor.redColor()
        default: break
        }
    }
        
    func loadRankData() {
        let url = NSURL(string: urlString)!
        do {
            self.htmlString = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
            
            if let html = Kanna.HTML(html: htmlString as! String, encoding: NSUTF8StringEncoding) {
                
                for content in html.xpath("//tbody/tr[contains(@class,'first odd')][1]/td[contains(@class,'team_a_col total')]") {
                    supportTeamRank = content.text
                }
            }
            
        } catch {
            print("error")
        }

    }
    
    
}
