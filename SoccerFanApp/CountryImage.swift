//
//  CountryImage.swift
//  SoccerFanApp
//
//  Created by Yong Jae Kim on 2015. 12. 13..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit

class CountryImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 1.0
        layer.shadowOffset = CGSizeMake(0.0, 1.0)
    }

}
