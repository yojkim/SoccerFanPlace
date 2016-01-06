//
//  MatchData.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2016. 1. 6..
//  Copyright © 2016년 Yong Jae Kim. All rights reserved.
//

import Foundation
import Kanna

class MatchData {
    
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
    
    var recentMatchIndex: Int!
    
    var recentHomeTeam: String!
    var recentAwayTeam: String!
    var recentHomeScore: String!
    var recentAwayScore: String!
    
    var recentLeague: String!
    var recentMatchResult: Int!
    
    
    
    private func removeData() {
        
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
    
    func loadMatchData(start: Int, end: Int) {
        
        self.removeData()
        
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
                for content in html.xpath("//table/tbody/tr/td[contains(@class,'team-b')]/a") {
                    if (count >= start && count <= end) {
                        if let away = content["title"] {
                            awayTeam.append("\(away.stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString(" ", withString: ""))")
                        }
                        
                    }
                    count++
                }
                
                count = 0
                
                //date
                for content in html.xpath("//table/tbody/tr/td[contains(@class,'full-date')]"){
                    if (count >= start && count <= end) {
                        if let date = content.text {
                            let trimmedDate = date.stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "")
                            
                            print(trimmedDate)
                            
                            let day = trimmedDate.componentsSeparatedByString("/")[0]
                            let month = trimmedDate.componentsSeparatedByString("/")[1]
                            let year = trimmedDate.componentsSeparatedByString("/")[2]
                            self.dayArray.append(day)
                            self.monthArray.append(month)
                            self.yearArray.append(year)
                            
                            self.dateArray.append("20\(year)년 \(month)월 \(day)일")
                        }
                    }
                    
                    count++
                }
                
                count = 0
                
                // league
                for content in html.xpath("//table/tbody/tr/td[contains(@class,'competition')]/a") {
                    
                    if (count >= start && count <= end) {
                        if let league = content["title"] {
                            self.leagueArray.append("\(league)")
                        }
                    }
                    
                    count++
                    
                }
                
                count = 0
                
                // score
                for content in html.xpath("//td[contains(@class,'score-time')]/a") {
                    // last 6 matches
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
                                    self.recentMatchIndex = count
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
                                    self.recentMatchIndex = count
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
                                scoreTimeArray.append("시간미정")
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
                
                saveRecentMatch()
            }
            
        } catch {
            print("error")
        }
        
    }
    
    func saveRecentMatch() {
        self.recentHomeTeam = self.homeTeam[recentMatchIndex]
        self.recentAwayTeam = self.awayTeam[recentMatchIndex]
        self.recentHomeScore = self.scoreTimeArray[recentMatchIndex].componentsSeparatedByString("-")[0]
        self.recentAwayScore = self.scoreTimeArray[recentMatchIndex].componentsSeparatedByString("-")[1]
        self.recentMatchResult = self.matchResult[recentMatchIndex]
        self.recentLeague = self.leagueArray[recentMatchIndex]
    }

}
