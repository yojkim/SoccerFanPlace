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
    
    var htmlString: NSString?
    var teamArray: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSoccerTeamData()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadSoccerTeamData() {
        let url = NSURL(string: "\(SOCCER_DEFAULT)\(SOCCER_BUNDES)")
        
        do {
            self.htmlString = try NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding)
            
            if let html = Kanna.HTML(html: htmlString as! String, encoding: NSUTF8StringEncoding) {
                for content in html.xpath("//table[@id='page_competition_1_block_competition_tables_8_block_competition_league_table_1_table']/tbody/tr/td[@class='text team large-link']/a") {
                    print("\(content["title"]!)")
                    teamArray.append("\(content["title"]!)")
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
            
            cell.configureCell(name)
            return cell
            
        } else {
            return TeamCell()
        }
    }
}
