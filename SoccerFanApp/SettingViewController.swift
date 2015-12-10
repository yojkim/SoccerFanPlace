//
//  SettingViewController.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2015. 12. 8..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {
    
    @IBOutlet var notiSwitch: UISwitch!
    @IBOutlet var navigationView: UIView!
    
    let transitionManager = TransitionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let window = UIApplication.sharedApplication().delegate!.window!!
        let navigationViewRect = CGRectMake(0, 0, self.navigationView.frame.size.width/2, self.navigationView.frame.size.height)

        self.navigationView.frame = navigationViewRect
        window.addSubview(navigationView)
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationView.removeFromSuperview()
    }
    
    override func viewWillAppear(animated: Bool) {
        let window = UIApplication.sharedApplication().delegate!.window!!
        window.addSubview(navigationView)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (indexPath.section == 0 && indexPath.row == 0) {

            self.performSegueWithIdentifier("SelectSegue", sender: nil)
            
        } else if (indexPath.section == 2 && indexPath.row == 1) {
            
            // mail to youthful2016@gmail.com
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SelectSegue" {
            if let selectView = segue.destinationViewController as? TeamSelectViewController {
                selectView.transitioningDelegate = self.transitionManager
            }
        }
    }
}
