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
    
    private var _supportTeam: NSString {
        get {
            var tempString: NSString? = NSUserDefaults.standardUserDefaults().objectForKey("supportTeam") as? NSString
            if tempString == nil {
                tempString = "팀을 선택해주세요."
            }
            
            return tempString!
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
    
    var supportLeague: NSString {
        get {
            return _supportLeague
        }
        
        set(newValue) {
            _supportLeague = newValue
            print(supportLeague)
        }
    }
    
    var supportTeam: NSString {
        get {
            return _supportTeam
        }
        
        set(newValue) {
            _supportTeam = newValue
            print(newValue)
        }
    }
    
    var supportTeamIndex: Int {
        get {
            return _supportTeamIndex
        }
        
        set(newValue) {
            _supportTeamIndex = newValue
            print(newValue)
        }
    }
    
}