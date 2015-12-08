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
    
    var leagueArray = ["프리미어리그","챔피온십리그","프리메라리가","분데스리가","세리에A","에레데비지에","리그1","프리메이라리가"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}
