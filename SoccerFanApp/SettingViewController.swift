//
//  SettingViewController.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2015. 12. 8..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit
import MessageUI

class SettingViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var teamLbl: UILabel!
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
        self.teamLbl.text = "\(DataServices.ds.supportTeam!)"
        let window = UIApplication.sharedApplication().delegate!.window!!
        window.addSubview(navigationView)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (indexPath.section == 0 && indexPath.row == 0) {

            self.performSegueWithIdentifier("LeagueSelectSegue", sender: nil)
            
        // mail to youthful2016@gmail.com
        } else if (indexPath.section == 1 && indexPath.row == 1) {
            let mailComposeViewController = configureMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
            
        }
        
    }
    
    // mail part --------------
    func configureMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerViewController = MFMailComposeViewController()
        mailComposerViewController.mailComposeDelegate = self
        
        mailComposerViewController.setToRecipients(["youthful2016@gmail.com"])
        mailComposerViewController.setSubject("")
        mailComposerViewController.setMessageBody("건의사항 혹은 연락 : ", isHTML: false)
        
        return mailComposerViewController
    }
    
    func showSendMailErrorAlert() {
        
        let alertView = UIAlertController(title: "메일을 보낼 수 없습니다.", message: "", preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "확인", style: .Default, handler: nil )
        
        alertView.addAction(alertAction)
        
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    // ------------------------
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "LeagueSelectSegue" {
            if let selectView = segue.destinationViewController as? LeagueSelectViewController {
                selectView.transitioningDelegate = self.transitionManager
            }
        }
    }
}
