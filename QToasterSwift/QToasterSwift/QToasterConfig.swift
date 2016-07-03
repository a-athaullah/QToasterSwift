//
//  QToasterConfig.swift
//  this class is default configuration and helper class and helper for QToasterSwift
//  QToasterSwift
//
//  Created by Ahmad Athaullah on 7/4/16.
//  Copyright © 2016 Ahmad Athaullah. All rights reserved.
//

import UIKit

class QToasterConfig: NSObject {
    
    class var textFont:UIFont{
        get{
            return UIFont.systemFontOfSize(11.0)
        }
    }
    class var titleFont:UIFont{
        get{
            return UIFont.systemFontOfSize(11.0, weight: 0.8)
        }
    }
    
    class var backgroundColor:UIColor{
        get{
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        }
    }
    class var textColor:UIColor{
        get{
            return UIColor.whiteColor()
        }
    }
    class var iconBackgroundColor:UIColor{
        get{
            return UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        }
    }
    
    class var animateDuration:NSTimeInterval{
        get{
            return 0.2
        }
    }
    class var delayDuration:NSTimeInterval{
        get{
            return 3.0
        }
    }
    
    class var iconSquareSize:NSTimeInterval{
        get{
            return 35.0
        }
    }
    class var iconCornerRadius:NSTimeInterval{
        get{
            return 3.0
        }
    }
}
