//
//  IntroViewController.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2016. 1. 8..
//  Copyright © 2016년 Yong Jae Kim. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func supportTeamButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("LeagueSelectSegue", sender: nil)
    }
}
