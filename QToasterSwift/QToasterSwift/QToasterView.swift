//
//  QToasterView.swift
//  QToasterSwift
//
//  Created by Ahmad Athaullah on 7/3/16.
//  Copyright © 2016 Ahmad Athaullah. All rights reserved.
//

import UIKit

class QToasterView: UIButton {
    
    var toaster = QToasterSwift()
    var viewArea = UIView()
    
    var minHeight:CGFloat{
        return self.statusBarHeight + 40
    }
    var textSize:CGSize{
        if toaster.iconImage == nil && (toaster.iconURL == nil || toaster.iconURL == "") {
            return textSize(toaster.text, font: toaster.textFont, maxWidth: self.width - 20)
        }else{
            return textSize(toaster.text, font: toaster.textFont, maxWidth: self.width - toaster.iconSquareSize - 25)
        }
    }
    var titleSize:CGSize{
        if toaster.titleText != nil && toaster.titleText != ""{
            if toaster.iconImage == nil && (toaster.iconURL == nil || toaster.iconURL == "") {
                return textSize(toaster.titleText!, font: toaster.textFont, maxWidth: self.width - 20)
            }else{
                return textSize(toaster.titleText!, font: toaster.textFont, maxWidth: self.width -  toaster.iconSquareSize - 25)
            }
        }else{
            return CGSizeMake(0, 0)
        }
    }
    
    var width:CGFloat{
        get{
            return UIScreen.mainScreen().bounds.size.width
        }
    }
    
    var statusBarHeight:CGFloat{
        get{
            return UIApplication.sharedApplication().statusBarFrame.size.height
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    // The storyboard loader uses this at runtime.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit(){
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.tag = 1313
    }
    
    
    func setupToasterView(toaster: QToasterSwift){
        self.toaster = toaster
        
        var textAreaWidth =  self.width - 20
        var imageToasterHeight:CGFloat = 0
        var textXPos:CGFloat = 10
        
        if toaster.iconImage != nil || (toaster.iconURL != nil && toaster.iconURL != ""){
            imageToasterHeight = toaster.iconSquareSize + self.statusBarHeight + 20
            textAreaWidth -= (toaster.iconSquareSize + 5)
            toaster.textAlignment = NSTextAlignment.Left
            textXPos += toaster.iconSquareSize + 5
        }
        
        var toasterHeight = self.textSize.height + self.titleSize.height + self.statusBarHeight + 20
        if self.titleSize.height > 0 {
            toasterHeight += 3
        }
        if toasterHeight < self.minHeight {
            toasterHeight = self.minHeight
        }
        
        if toasterHeight < imageToasterHeight{
            toasterHeight = imageToasterHeight
        }
        
        
        var yPos:CGFloat = self.statusBarHeight + 10
        
        let toasterViewFrame = CGRectMake(0,0 - toasterHeight, self.width,toasterHeight)
        
        viewArea.frame = toasterViewFrame
        viewArea.userInteractionEnabled = false
        viewArea.backgroundColor = toaster.backgroundColor
        
        if toaster.iconImage != nil || (toaster.iconURL != nil && toaster.iconURL != ""){
            let iconView = UIImageView(frame: CGRectMake(10, yPos, toaster.iconSquareSize, toaster.iconSquareSize))
            iconView.backgroundColor = toaster.iconBackgroundColor
            iconView.layer.cornerRadius = toaster.iconCornerRadius
            iconView.clipsToBounds = true
            
            if toaster.iconImage != nil {
                iconView.image = toaster.iconImage
            }
            if toaster.iconURL != nil && toaster.iconURL != "" {
                imageForUrl(toaster.iconURL!, completionHandler:{(image: UIImage?, url: String) in
                    iconView.image = image
                })
            }
            viewArea.addSubview(iconView)
        }
        
        if toaster.titleText != nil && toaster.titleText != "" {
            let titleLabel = UILabel(frame: CGRectMake(textXPos, yPos, textAreaWidth, self.titleSize.height))
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = toaster.textAlignment
            titleLabel.text = toaster.titleText
            titleLabel.textColor = toaster.textColor
            titleLabel.font = toaster.titleFont
            viewArea.addSubview(titleLabel)
            yPos += 3 + self.titleSize.height
        }else{
            yPos = ((toasterHeight - self.textSize.height) / 2) + 10
        }
        
        let textLabel = UILabel(frame: CGRectMake(textXPos, yPos, textAreaWidth, self.textSize.height))
        textLabel.text = toaster.text
        textLabel.textAlignment = toaster.textAlignment
        textLabel.textColor = toaster.textColor
        textLabel.numberOfLines = 0
        textLabel.font = toaster.textFont
        viewArea.addSubview(textLabel)
        
        self.frame = CGRectMake(0, 0, self.width, toasterHeight)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.addTarget(self, action: #selector(QToasterSwift.touchAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(viewArea)
    }
    
    func textSize(text: NSString, font: UIFont, maxWidth: CGFloat)->CGSize{
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
    func imageForUrl(urlString: String, completionHandler:(image: UIImage?, url: String) -> ()) {
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
