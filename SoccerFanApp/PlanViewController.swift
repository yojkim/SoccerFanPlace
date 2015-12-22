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
    var teamDict = Dictionary<String, String>()
    var scoreTimeArray = [String]()
    var matchStatus = [String]() // 현재 경기 상태 ex) 준비중, 진행중(예정), 종료
    
    let matchResults = ["win","draw","loss"] // 경기 결과 check를 위한 배열
    var matchResult = [Int]() // 경기 결과 ex) -1 : 아직 진행 안함, 0 : 승, 1 : 무, 2 : 패
    

    override func viewDidLoad() {
        loadSoccerTeamData(23, end: 28)
        super.viewDidLoad()
    }
    
    func loadSoccerTeamData(start: Int, end: Int) {
        
        var homeTeam: String?
        var awayTeam: String?
        var score: String?
        var time: String?
        
        
        var count = 0
        let url: NSURL!
        if let temp = urlString {
            print(temp)
            url = NSURL(string: "\(SOCCER_DEFAULT)\(temp)")
        } else {
            url = NSURL(string: "\(SOCCER_DEFAULT)\(LEAGUE_PREMIER)")
        }
        
        do {
            self.htmlString = try NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding)
            
            if let html = Kanna.HTML(html: htmlString as! String, encoding: NSUTF8StringEncoding) {
                for content in html.xpath("/div[@id='page_team_1_block_team_matches_summary_8']/div[@class='table-container']/table[@class='matches   ']/tbody/tr[@class='match no-date-repetition']") {
                    
                    if (count >= start && count <= end) {
                        
                        
                        
                        homeTeam = "\(content.xpath("/td[@class='team team-a']/a"))"
                        awayTeam = "\(content.xpath("/td[@class='team team-b']/a"))"
                        
                        score = "\(content.xpath("/td[@class='score-time score']/a"))"
                        time = "\(content.xpath("/td[@class='score-time status']/a"))"
                        
                        if homeTeam != nil && awayTeam != nil {
                            teamDict[homeTeam!] = awayTeam!
                        }
                        
                        if score != nil {
                            
                            for (index, result) in matchResults.enumerate() {
                                if "\(content.xpath("/td[@class='score-time score']/a[@class='result-\(result)']"))" != nil || "\(content.xpath("/td[@class='score-time score']/a[@class='result-\(result)']"))" != ""  {
                                    matchResult.append(index)
                                }
                            }
                            
                            scoreTimeArray.append(score!)
                            matchStatus.append("done")
                        } else if time != nil {
                            scoreTimeArray.append(time!)
                            matchStatus.append("ready")
                            matchResult.append(-1)
                        }
                        
                    } else {
                        
                    }
                    count++
            
                }
            }
            
        } catch {
            print("error")
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchStatus.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCellWithIdentifier("MatchCell") as? MatchCell {
            
            if matchStatus[indexPath.row] == "ready" {
                
                cell.configureCell(scoreTimeArray[indexPath.row], matchResult: nil, matchStatus: matchStatus[indexPath.row], home: Array(teamDict.keys)[indexPath.row], away: Array(teamDict.values)[indexPath.row], homeScore: nil, awayScore: nil)
            } else {
                
                let trimmedScore = String(String.stringByTrimmingCharactersInSet(scoreTimeArray[indexPath.row]))
                let homeScore = trimmedScore.componentsSeparatedByString("-")[0]
                let awayScore = trimmedScore.componentsSeparatedByString("-")[1]
                cell.configureCell(nil, matchResult: matchResult[indexPath.row], matchStatus: matchStatus[indexPath.row], home: Array(teamDict.keys)[indexPath.row], away: Array(teamDict.values)[indexPath.row], homeScore: homeScore, awayScore: awayScore)
            }
            
            return cell
            
        } else {
            let cell = MatchCell()
            return cell
        }
    }

}
