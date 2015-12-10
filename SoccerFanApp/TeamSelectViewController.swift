//
//  TeamSelectViewController.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2015. 12. 10..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit

class TeamSelectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
