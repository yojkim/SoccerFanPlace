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
    
    var urlString: String? = DataServices.ds.supportTeamURL
    var htmlString: NSString?
    var scoreTimeArray = [String]()
    var matchStatus = [String]() // 현재 경기 상태 ex) 준비중, 진행중(예정), 종료
    
    var homeTeam = [String]()
    var awayTeam = [String]()
    
    let matchResults = ["win","draw","loss","Cancelled"] // 경기 결과 check를 위한 배열
    var matchResult = [Int]() // 경기 결과 ex) -1 : 아직 진행 안함, 0 : 승, 1 : 무, 2 : 패
    
    var startPoint: Int!
    var skipCount: Int!
    
    override func viewDidLoad() {
        self.tableView.showsVerticalScrollIndicator = false
        
        startPoint = DataServices.ds.searchStartPoint
        skipCount = DataServices.ds.skipCount
        
        print(startPoint)
        loadMatchData(startPoint, end: startPoint+(5+self.skipCount))
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        super.viewDidLoad()
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        urlString = DataServices.ds.supportTeamURL
        
        startPoint = DataServices.ds.searchStartPoint
        skipCount = DataServices.ds.skipCount
        print(startPoint)
        loadMatchData(startPoint, end: startPoint+(5+self.skipCount))
        tableView.reloadData()
        super.viewDidAppear(true)
    }
    
    func loadMatchData(start: Int, end: Int) {
        
        scoreTimeArray.removeAll()
        awayTeam.removeAll()
        homeTeam.removeAll()
        matchStatus.removeAll()
        matchResult.removeAll()
        
        var count = 0
        var totalCount = 0 // scoreTimeArray Count
        let url: NSURL!
        if let temp = urlString {
            print("\(temp)matches")
            url = NSURL(string: "\(temp)matches/")
        } else {
            url = NSURL(string: "http://kr.soccerway.com/teams/england/manchester-city-football-club/676/matchesasdf")
        }
        
        do {
            self.htmlString = try NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding)
            
            if let html = Kanna.HTML(html: htmlString as! String, encoding: NSUTF8StringEncoding) {
                
                count = 0
                
                // home Team
                for content in html.xpath("//table/tbody/tr/td[contains(@class,'team-a')]/a") {
                    if (count >= start && count <= end) {
                        
                        if let home = content["title"] {
                            homeTeam.append("\(home)")
                        }
                        
                    }
                    
                    count++
            
                }
                
                count = 0
                
                // away Team
                for content in html.xpath("//table/tbody/tr/td[contains(@class,'team-b')]") {
                    if (count >= start && count <= end) {
                        if let away = content.text {
                            awayTeam.append("\(away.stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString(" ", withString: ""))")
                        }
                        
                    }
                    count++
                }
                
                count = 0
                
                // score
                /*for content in html.xpath("//td[contains(@class,'score-time score')]/a") {
                    if (count >= start && count <= end) {
                        
                        if let score = content.innerHTML {
                            scoreTimeArray.append("\(score)")
                            matchStatus.append("done")
                        }
                        
                        for (index, result) in matchResults.enumerate() {
                            print(index)
                            if let outcome = content["class"] {
                                if "\(outcome)" == "result-\(result)" || "\(outcome)" == "\(result)" {
                                    matchResult.append(index)
                                }
                            }
                        }
                        
                    }
                    
                    count++
                }*/
                
                for content in html.xpath("//td[contains(@class,'score-time')]/a") {
                    if start == 44-(self.skipCount) {
                        if (count >= start && count <= DataServices.ds.lastIndex) {
                            
                            if let score = content.innerHTML {
                                let trimmedScore = score.stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "")
                                if trimmedScore == "CANC" {
                                    homeTeam.removeAtIndex(totalCount)
                                    awayTeam.removeAtIndex(totalCount)
                                } else {
                                    scoreTimeArray.append("\(score)")
                                    matchStatus.append("done")
                                }
                                totalCount++
                            }
                            
                            for (index, result) in matchResults.enumerate() {
                                print(index)
                                if let outcome = content["class"] {
                                    if "\(outcome)" == "result-\(result)" || "\(outcome)" == "\(result)" {
                                        matchResult.append(index)
                                    }
                                }
                            }
                            
                        }
                    } else {
                        if (count >= start && count < start+(2+self.skipCount)) {
                            
                            if let score = content.innerHTML {
                                let trimmedScore = score.stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "")
                                if trimmedScore == "CANC" {
                                    homeTeam.removeAtIndex(totalCount)
                                    awayTeam.removeAtIndex(totalCount)
                                } else {
                                    scoreTimeArray.append("\(score)")
                                    matchStatus.append("done")
                                }
                                totalCount++
                            }
                            
                            for (index, result) in matchResults.enumerate() {
                                print(index)
                                if let outcome = content["class"] {
                                    if "\(outcome)" == "result-\(result)" || "\(outcome)" == "\(result)" {
                                        matchResult.append(index)
                                    }
                                }
                            }
                            
                        }
                    }
                    
                    count++
                }
                
                count = start-(startPoint+2+self.skipCount)-self.skipCount
                
                // time
                for content in html.xpath("//td[contains(@class,'status')]/a") {
                    if (count >= start-(startPoint+2+self.skipCount) && count < end-(startPoint+2+self.skipCount)-self.skipCount-1) {
                        if let time = content.text {
                            let trimmedTime = time.stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "")
                            
                            if trimmedTime == "-" {
                                scoreTimeArray.append("미정")
                            } else {
                                let hour = trimmedTime.componentsSeparatedByString(":")[0]
                                let min = trimmedTime.componentsSeparatedByString(":")[1]
                                print(hour)
                                var koreanHour = Int(hour)!+8
                                if koreanHour >= 24 {
                                    koreanHour = koreanHour - 24
                                }
                        
                                if koreanHour <= 9 {
                                    scoreTimeArray.append("0\(koreanHour):\(min)")
                                } else {
                                    scoreTimeArray.append("\(koreanHour):\(min)")
                                }
                            }
                        
                            matchStatus.append("ready")
                            matchResult.append(-1)
                        }
                    } else if count >= end-(startPoint+2+self.skipCount)-self.skipCount {
                        break
                    }
                    
                    count++
                }
            }
            
        } catch {
            print("error")
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeTeam.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCellWithIdentifier("MatchCell") as? MatchCell {
            print(indexPath.row)
            
            for index in scoreTimeArray {
                print(index)
            }
            if matchStatus[indexPath.row] == "ready" {
                
                cell.configureCell(scoreTimeArray[indexPath.row], matchResult: nil, matchStatus: matchStatus[indexPath.row], home: homeTeam[indexPath.row], away: awayTeam[indexPath.row], homeScore: nil, awayScore: nil)
            } else {
                
                let trimmedScore = scoreTimeArray[indexPath.row].stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "")
                let homeScore = Int(trimmedScore.componentsSeparatedByString("-")[0])!
                let awayScore = Int(trimmedScore.componentsSeparatedByString("-")[1])!
                cell.configureCell(nil, matchResult: matchResult[indexPath.row], matchStatus: matchStatus[indexPath.row], home: homeTeam[indexPath.row], away: awayTeam[indexPath.row], homeScore: homeScore, awayScore: awayScore)
            }
            
            return cell
            
        } else {
            let cell = MatchCell()
            return cell
        }
    }

}
