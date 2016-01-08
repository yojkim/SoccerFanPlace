//
//  PlanViewController.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2015. 12. 8..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit
import Kanna

class PlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var matchData = MatchData()
    
    var urlString: String? = DataServices.ds.supportTeamURL
    var htmlString: NSString?
    var scoreTimeArray = [String]()
    var matchStatus = [String]() // 현재 경기 상태 ex) 준비중, 진행중(예정), 종료
    
    var homeTeam = [String]()
    var awayTeam = [String]()
    
    var dayArray = [String]()
    var monthArray = [String]()
    var yearArray = [String]()
    var dateArray = [String]()
    
    var leagueArray = [String]()
    
    let matchResults = ["win","draw","loss","Cancelled"] // 경기 결과 check를 위한 배열
    var matchResult = [Int]() // 경기 결과 ex) -1 : 아직 진행 안함, 0 : 승, 1 : 무, 2 : 패
    
    var startPoint: Int!
    var skipCount: Int!
    
    override func viewDidLoad() {
        self.tableView.showsVerticalScrollIndicator = false
        
        startPoint = DataServices.ds.searchStartPoint
        skipCount = DataServices.ds.skipCount
        
        self.matchData.startPoint = self.startPoint
        self.matchData.skipCount = self.skipCount
        
        self.removeData()
        self.matchData.loadMatchData(startPoint, end: startPoint+(5+self.skipCount))
        self.receiveData()
        tableView.reloadData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        super.viewDidLoad()
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        urlString = DataServices.ds.supportTeamURL
        
        startPoint = DataServices.ds.searchStartPoint
        skipCount = DataServices.ds.skipCount
        
        self.matchData.startPoint = self.startPoint
        self.matchData.skipCount = self.skipCount
        
        self.removeData()
        self.matchData.loadMatchData(startPoint, end: startPoint+(5+self.skipCount))
        self.receiveData()
        tableView.reloadData()
        super.viewDidAppear(true)
    }
    
    func removeData() {
        
        dayArray.removeAll()
        monthArray.removeAll()
        yearArray.removeAll()
        dateArray.removeAll()
        leagueArray.removeAll()
        
        scoreTimeArray.removeAll()
        awayTeam.removeAll()
        homeTeam.removeAll()
        matchStatus.removeAll()
        matchResult.removeAll()
    }
    
    func receiveData(){
        scoreTimeArray = self.matchData.scoreTimeArray
        matchStatus = self.matchData.matchStatus
        
        homeTeam = self.matchData.homeTeam
        awayTeam = self.matchData.awayTeam
        
        dayArray = self.matchData.dayArray
        monthArray = self.matchData.monthArray
        yearArray = self.matchData.yearArray
        dateArray = self.matchData.dateArray
        
        leagueArray = self.matchData.leagueArray
        matchResult = self.matchData.matchResult
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeTeam.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCellWithIdentifier("MatchCell") as? MatchCell {
            if matchStatus[indexPath.row] == "ready" {
                
                cell.configureCell(scoreTimeArray[indexPath.row], matchResult: nil, matchStatus: matchStatus[indexPath.row], home: homeTeam[indexPath.row], away: awayTeam[indexPath.row], homeScore: nil, awayScore: nil, date: dateArray[indexPath.row], leagueName: leagueArray[indexPath.row])
            } else {
                
                let trimmedScore = scoreTimeArray[indexPath.row].stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "")
                let homeScore = Int(trimmedScore.componentsSeparatedByString("-")[0])!
                let awayScore = Int(trimmedScore.componentsSeparatedByString("-")[1])!
                cell.configureCell(nil, matchResult: matchResult[indexPath.row], matchStatus: matchStatus[indexPath.row], home: homeTeam[indexPath.row], away: awayTeam[indexPath.row], homeScore: homeScore, awayScore: awayScore, date: dateArray[indexPath.row], leagueName: leagueArray[indexPath.row])
            }
            
            return cell
            
        } else {
            let cell = MatchCell()
            return cell
        }
    }

}
