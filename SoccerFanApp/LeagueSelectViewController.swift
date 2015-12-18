//
//  LeagueSelectViewController.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2015. 12. 13..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit

class LeagueSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var leagueArray = ["프리미어리그(ENG)","챔피온십리그(ENG)","프리메라리가(ESP)","분데스리가(GER)","세리에A(ITA)","에레데비지에(NED)","리그1(FRA)","프리메이라리가(POR)", "K리그클래식(KOR)"]
    var urlArray = [LEAGUE_PREMIER,LEAGUE_CHAMPIONSHIP,LEAGUE_PRIMERA_ESP,LEAGUE_BUNDES,LEAGUE_SERIA,LEAGUE_EREDIVISIE,LEAGUE_LIGA1,LEAGUE_PRIMERA_POR,LEAGUE_KLEAGUE]
    var countryArray = ["ENG","ENG","ESP","GER","ITA","NED","FRA","POR","KOR"]
    
    let transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let name = leagueArray[indexPath.row]
        let image = countryArray[indexPath.row]
        
        if let cell = self.tableView.dequeueReusableCellWithIdentifier("LeagueCell") as? LeagueCell {
            
            cell.configureCell(name, countryImage: image)
            return cell
        } else {
            return LeagueCell()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leagueArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("TeamSelectSegue", sender: nil)
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TeamSelectSegue" {
            let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow!
            if let selectView = segue.destinationViewController as? TeamSelectViewController {
                selectView.transitioningDelegate = self.transitionManager
                selectView.leagueString = leagueArray[indexPath.row]
                selectView.urlString = urlArray[indexPath.row]
            }
        }
    }
}
