//
//  TeamSelectViewController.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2015. 12. 10..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit
import Kanna

class TeamSelectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    static var teamCache = NSCache()
    
    var leagueString: NSString!
    var htmlString: NSString?
    
    var teamArray: [String] = []
    var teamLinks: [String] = []
    var teamDictionary = Dictionary<String,String>()
    var urlString: String?
    var count: Int = 0
    
    var rawContent: String!
    
    override func viewDidLoad() {
        loadSoccerTeamData()
        sortTeamDictionary()
        //sortedTeamArray = teamArray.sort { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func confirmButtonPressed(sender: AnyObject) {
        if DataServices.ds.supportTeam != nil && DataServices.ds.supportTeam != "" {
            DataServices.ds.isFirstime = false
            self.performSegueWithIdentifier("MainViewSegue", sender: nil)
        }
        
    }
    
    func loadSoccerTeamData() {
        
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
                for content in html.xpath("//table[@id='page_competition_1_block_competition_tables_8_block_competition_league_table_1_table']/tbody/tr/td[@class='text team large-link']/a") {
                    
                    teamDictionary["\(content["title"]!)"] = "\(content["href"]!)"
                    count++
                }
            }
            
        } catch {
            print("error")
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teamArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let name = teamArray[indexPath.row]
        
        if let cell = self.tableView.dequeueReusableCellWithIdentifier("TeamCell") as? TeamCell {
            if DataServices.ds.supportTeamIndex == indexPath.row && DataServices.ds.supportLeague == leagueString {
                print(indexPath.row)
                print(teamArray[indexPath.row])
                cell.configureCell(name, checked: true)
            } else {
                cell.configureCell(name, checked: false)

            }
            return cell
            
        } else {
            let cell = TeamCell()
            
            print(cell.teamLbl.text!)
            print(DataServices.ds.supportTeam)
            if DataServices.ds.supportTeamIndex == indexPath.row && DataServices.ds.supportLeague == leagueString {
                print(indexPath.row)
                cell.checkImage.hidden = false
                cell.checkImage.image = UIImage(named: "Check")
            }
            return cell
        }
    }
    
    // tableViewCell selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        for i in 0..<count {
            let indexPath: NSIndexPath = NSIndexPath(forRow: i, inSection: 0)
            let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? TeamCell
            
            cell?.checkImage.hidden = true
            
        }
        
        if let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? TeamCell {
            
            // select same thing
            if DataServices.ds.supportTeamIndex == indexPath.row && DataServices.ds.supportLeague == leagueString {
                print(cell.teamLbl.text!)
                cell.checkImage.hidden = false
                cell.checkImage.image = UIImage(named: "Check")
            }
                
            // select new thing
            else {
                print(cell.teamLbl.text!)
                DataServices.ds.supportTeam = cell.teamLbl.text!
                DataServices.ds.supportTeamURL = "\(SOCCER_DEFAULT)\(teamLinks[indexPath.row])"
                setStartPoint()
                DataServices.ds.supportLeague = self.leagueString
                DataServices.ds.supportTeamIndex = indexPath.row
                
                cell.checkImage.hidden = false
                cell.checkImage.image = UIImage(named: "Check")
            }
            
        }
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func sortTeamDictionary() {
        
        let tempArray = teamDictionary.sort { $0.0 < $1.0 }
        
        teamArray = tempArray.map { return $0.0 }
        teamLinks = tempArray.map { return $0.1 }
    }
    
    func setStartPoint() {
        
        urlString = DataServices.ds.supportTeamURL
        
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
                
                var count = 0
                var skip = 0
                for content in html.xpath("//td[contains(@class,'score-time')]/a") {
                    // if class value exist?
                    if let result = content["class"] {
                        if count >= 46 && count <= 49 {
                            DataServices.ds.searchStartPoint = 44 - skip
                            DataServices.ds.skipCount = skip
                            DataServices.ds.lastIndex = count
                        }
                    } else {
                        
                        if content["title"] == "Cancelled" {
                            skip++
                            if count == 49 {
                                DataServices.ds.searchStartPoint = count-(5+skip)
                                DataServices.ds.skipCount = skip
                                DataServices.ds.lastIndex = count
                            }
                        } else {
                            if count >= 46 && count <= 49 {
                                DataServices.ds.searchStartPoint = 44 - skip
                                DataServices.ds.skipCount = skip
                                DataServices.ds.lastIndex = count-1
                            } else {
                                DataServices.ds.searchStartPoint = count-(2+skip)
                                DataServices.ds.skipCount = skip
                                DataServices.ds.lastIndex = count
                                print("startPoint : \(count-(2+skip))")
                            }
                            break
                        }
                    }
                    count++
                }
            }

            
        } catch {
            print("error")
        }
        
    }
}
