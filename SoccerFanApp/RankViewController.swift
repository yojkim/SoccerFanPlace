//
//  RankViewController.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2015. 12. 8..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit

class RankViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var leagueArray = ["프리미어리그(ENG)","챔피온십리그(ENG)","프리메라리가(ESP)","분데스리가(GER)","세리에A(ITA)","에레데비지에(NED)","리그1(FRA)","프리메이라리가(POR)"]
    var leagueUrlArray = ["http://m.sports.naver.com/wfootball/record/index.nhn","http://kr.soccerway.com/national/england/championship/20152016/regular-season/r31555/","http://m.sports.naver.com/wfootball/record/index.nhn?category=primera&year=2015","http://m.sports.naver.com/wfootball/record/index.nhn?category=bundesliga&year=2015","http://m.sports.naver.com/wfootball/record/index.nhn?category=seria&year=2015","http://m.sports.naver.com/wfootball/record/index.nhn?category=eredivisie&year=2015","http://m.sports.naver.com/wfootball/record/index.nhn?category=ligue1&year=2015","http://kr.soccerway.com/national/portugal/portuguese-liga-/20152016/regular-season/r31637/"]
    
    let transitionManager = TransitionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let name = leagueArray[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("LeagueCell") as? LeagueCell {
            
            cell.configureCell(name)
            
            return cell
            
        } else {
            
            return LeagueCell()
            
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("LeagueSegue", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "LeagueSegue" {
            let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow!
            if let detailView = segue.destinationViewController as? RankDetailViewController {
                detailView.transitioningDelegate = self.transitionManager
                detailView.LeagueName = self.leagueArray[indexPath.row]
                detailView.LeagueUrl = self.leagueUrlArray[indexPath.row]
            }
        }
    }
}
