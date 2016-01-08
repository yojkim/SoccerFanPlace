//
//  DataServices.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2015. 12. 13..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import Foundation

class DataServices {
    static let ds = DataServices()
    
    private var _isFirstime: Bool {
        get {
            var tempBool: Bool? = NSUserDefaults.standardUserDefaults().objectForKey("firstTimeUser") as? Bool
            if tempBool == nil {
                tempBool = true
            }
            
            return tempBool!
        }
        
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "firstTimeUser")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    private var _supportLeague: NSString {
        get {
            var tempString: NSString? = NSUserDefaults.standardUserDefaults().objectForKey("supportLeague") as? NSString
            if tempString == nil {
                tempString = ""
            }
            
            return tempString!
        }
        
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "supportLeague")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    private var _supportTeam: NSString? {
        get {
            let tempString: NSString? = NSUserDefaults.standardUserDefaults().objectForKey("supportTeam") as? NSString
            
            return tempString
        }
        
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "supportTeam")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    private var _supportTeamIndex: Int {
        get {
            var tempInt = NSUserDefaults.standardUserDefaults().objectForKey("supportTeamIndex") as? Int
            if tempInt == nil {
                tempInt = -1
            }
            
            return tempInt!
        }
        
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "supportTeamIndex")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    private var _supportTeamURL: String {
        get {
            var tempString = NSUserDefaults.standardUserDefaults().objectForKey("supportTeamURL") as? String
            if tempString == nil {
                tempString = "http://kr.soccerway.com/teams/england/newcastle-united-football-club/664/"
            }
            
            return tempString!
        }
        
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "supportTeamURL")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    private var _searchStartPoint: Int {
        get {
            var tempInt = NSUserDefaults.standardUserDefaults().objectForKey("searchStartPoint") as? Int
            
            if tempInt == nil {
                tempInt = 23
            }
            
            return tempInt!
        }
        
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "searchStartPoint")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    private var _skipCount: Int {
        get {
            var tempInt = NSUserDefaults.standardUserDefaults().objectForKey("skipCount") as? Int
            
            if tempInt == nil {
                tempInt = 0
            }
            
            return tempInt!
        }
        
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "skipCount")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    private var _lastIndex: Int {
        get {
            var tempInt = NSUserDefaults.standardUserDefaults().objectForKey("lastIndex") as? Int
            
            if tempInt == nil {
                tempInt = 0
            }
            
            return tempInt!
        }
        
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "lastIndex")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var isFirstime: Bool {
        get {
            return _isFirstime
        }
        set(newValue) {
            _isFirstime = newValue
        }
    }
    
    var supportLeague: NSString {
        get {
            return _supportLeague
        }
        
        set(newValue) {
            _supportLeague = newValue
        }
    }
    
    var supportTeam: NSString? {
        get {
            return _supportTeam
        }
        
        set(newValue) {
            _supportTeam = newValue
        }
    }
    
    var supportTeamIndex: Int {
        get {
            return _supportTeamIndex
        }
        
        set(newValue) {
            _supportTeamIndex = newValue
        }
    }
    
    var supportTeamURL: String {
        get {
            return _supportTeamURL
        }
        
        set(newValue) {
            _supportTeamURL = newValue
        }
    }
    
    var searchStartPoint: Int {
        get {
            return _searchStartPoint
        }
        
        set(newValue) {
            _searchStartPoint = newValue
        }
    }
    
    var skipCount: Int {
        get {
            return _skipCount
        }
        
        set(newValue) {
            _skipCount = newValue
        }
    }
    
    var lastIndex: Int {
        get {
            return _lastIndex
        }
        
        set(newValue) {
            _lastIndex = newValue
        }
    }
    
}