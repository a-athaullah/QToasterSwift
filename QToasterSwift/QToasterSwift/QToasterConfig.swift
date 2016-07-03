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
    
    class var iconSquareSize:CGFloat{
        get{
            return 35.0
        }
    }
    class var iconCornerRadius:CGFloat{
        get{
            return 3.0
        }
    }
    class var screenWidth:CGFloat{
        get{
            return UIScreen.mainScreen().bounds.size.width
        }
    }
    class var statusBarHeight:CGFloat{
        get{
            return UIApplication.sharedApplication().statusBarFrame.size.height
        }
    }
    
    class func textSize(text: NSString, font: UIFont, maxWidth: CGFloat)->CGSize{
        let rect = text.boundingRectWithSize(CGSizeMake(maxWidth, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil) as CGRect
        return rect.size
    }
    
    //  func imageForUrl
    //  taken from : ImageLoader.swift
    //  extension
    //
    //  Created by Nate Lyman on 7/5/14.
    //  git: https://github.com/natelyman/SwiftImageLoader
    //  Copyright (c) 2014 NateLyman.com. All rights reserved.
    //
    class func imageForUrl(urlString: String, completionHandler:(image: UIImage?, url: String) -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
            let cache = NSCache()
            let data: NSData? = cache.objectForKey(urlString) as? NSData
            
            if let goodData = data {
                let image = UIImage(data: goodData)
                dispatch_async(dispatch_get_main_queue(), {() in
                    completionHandler(image: image, url: urlString)
                })
                return
            }
            
            let downloadTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                if (error != nil) {
                    completionHandler(image: nil, url: urlString)
                    return
                }
                
                if let data = data {
                    let image = UIImage(data: data)
                    cache.setObject(data, forKey: urlString)
                    dispatch_async(dispatch_get_main_queue(), {() in
                        completionHandler(image: image, url: urlString)
                    })
                    return
                }
                
            })
            downloadTask.resume()
        })
        
    }
}
