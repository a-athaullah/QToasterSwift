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
    class func imageForUrl(urlString: String, header: [String : String] = [String : String](), completionHandler:(image: UIImage?, url: String) -> ()) {
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
            if header.count > 0 {
                let url = NSURL(string: urlString)
                let mutableRequest = NSMutableURLRequest(URL: url!)
                
                for (key, value) in header {
                    mutableRequest.setValue(key, forHTTPHeaderField: value)
                }
                
                let downloadTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(mutableRequest, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
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
            }else{
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
            }
        })
        
    }
    
    /*
    var stringUrl = "https://restcountries-v1.p.mashape.com/all"
    stringUrl = stringUrl.stringByReplacingOccurrencesOfString(" ", withString: "+")
    let url = NSURL(string: stringUrl)
    let session = NSURLSession.sharedSession()
    var muableRequest = NSMutableURLRequest(URL: url!)
    muableRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    muableRequest.setValue("9JPje8RP94mshA1Xc1qoEiw1Ozd3p1cGJxfjsnxv00RWij2MII", forHTTPHeaderField: "X-Mashape-Key")
    
    let task = session.dataTaskWithRequest(muableRequest, completionHandler: { (data, response, error) -> Void in
        if let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil){
            
            println(jsonResult)
            
        }
        
    })
    task.resume()
    */
}
