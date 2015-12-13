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
    var urlString: String?
    var count: Int = 0
    
    
    
    override func viewDidLoad() {
        loadSoccerTeamData()
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
                    teamArray.append("\(content["title"]!)")
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
            if DataServices.ds.supportTeam == cell.teamLbl.text! {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            
            cell.configureCell(name)
            return cell
            
        } else {
            let cell = TeamCell()
            if cell.teamLbl.text! == DataServices.ds.supportTeam {
                print("asdf")
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        for i in 0..<count {
            let indexPath: NSIndexPath = NSIndexPath(forRow: i, inSection: 0)
            let cell = self.tableView.cellForRowAtIndexPath(indexPath)
            
            cell?.accessoryType = UITableViewCellAccessoryType.None
        }
        
        if let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? TeamCell {
            
            if cell.teamLbl.text == DataServices.ds.supportTeam {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            else {
                DataServices.ds.supportTeam = cell.teamLbl.text!
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            
        }
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
