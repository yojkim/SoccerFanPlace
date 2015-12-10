//
//  RankDetailViewController.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2015. 12. 9..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit
import WebKit

class RankDetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var LeagueLbl: UILabel!
    @IBOutlet var container: UIView!
    @IBOutlet var progressBar: UIProgressView!
    
    var webView: WKWebView!
    
    var LeagueName: String!
    var LeagueUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // loaded by RankViewController
        self.LeagueLbl.text = self.LeagueName
        
    }
    
    override func viewDidAppear(animated: Bool) {
        setWebView()
    }

    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setWebView() {
        webView = WKWebView()
        container.addSubview(webView)

        // same frame with container
        let frame = CGRectMake(0, 0, container.bounds.width, container.bounds.height)
        webView.frame = frame
        
        let url = NSURL(string: LeagueUrl)
        let urlRequest = NSURLRequest(URL: url!)
        
        webView.loadRequest(urlRequest)
    }
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Data is loaded now!")
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("Data loading finished")
        
    }
}
