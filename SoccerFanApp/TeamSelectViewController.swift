//
//  TeamSelectViewController.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2015. 12. 10..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit

class TeamSelectViewController: UIViewController {

    var htmlString: NSString?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSoccerHTMLData()
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadSoccerHTMLData() {
        let url = NSURL(string: "\(SOCCER_DEFAULT)")
        
        do {
            self.htmlString = try NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding)
        } catch {
            print("error")
        }
        
        print(htmlString)
        print("==========================Success============================")
    }

}
