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
    
    private var _supportTeam: NSString {
        get {
            var tempString: NSString? = NSUserDefaults.standardUserDefaults().objectForKey("supportTeam") as? NSString
            if tempString == nil {
                tempString = "맨체스터 유나이티드"
            }
            
            return tempString!
        }
        
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "supportTeam")
            NSUserDefaults.standardUserDefaults().synchronize()
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
    
}