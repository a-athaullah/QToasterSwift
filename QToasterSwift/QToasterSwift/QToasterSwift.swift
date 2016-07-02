//
//  QToasterSwift.swift
//  QToasterSwift
//
//  Created by Ahmad Athaullah on 6/30/16.
//  Copyright © 2016 Ahmad Athaullah. All rights reserved.
//

import UIKit

public class QToasterSwift: NSObject {
    
    var minHeight:CGFloat{
        return self.statusBarHeight + 40
    }
    
    public var toastAction:()->Void = ({})
    public var textAlignment:NSTextAlignment = NSTextAlignment.Center
    public var textFont = UIFont.systemFontOfSize(11.0)
    public var titleFont = UIFont.systemFontOfSize(11.0, weight: 0.8)
    
    public var titleText:String?
    public var text:String = ""
    public var iconImage:UIImage?
    public var iconURL:String?
    
    public var backgroundColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    public var textColor: UIColor = UIColor.whiteColor()
    public var animateDuration:NSTimeInterval = 0.2
    public var delayDuration:NSTimeInterval = 4.0
    
    public var iconSquareSize:CGFloat = 35.0
    public var iconCornerRadius:CGFloat = 4.0
    public var iconBackgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    
    var textSize:CGSize{
        if self.iconImage == nil && (self.iconURL == nil || self.iconURL == "") {
            return textSize(self.text, font: self.textFont, maxWidth: self.width - 20)
        }else{
            return textSize(self.text, font: self.textFont, maxWidth: self.width - self.iconSquareSize - 25)
        }
    }
    var titleSize:CGSize{
        if self.titleText != nil && self.titleText != ""{
            if self.iconImage == nil && (self.iconURL == nil || self.iconURL == "") {
                return textSize(self.titleText!, font: self.textFont, maxWidth: self.width - 20)
            }else{
                return textSize(self.titleText!, font: self.textFont, maxWidth: self.width -  self.iconSquareSize - 25)
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
    
    
    func textSize(text: NSString, font: UIFont, maxWidth: CGFloat)->CGSize{
        let rect = text.boundingRectWithSize(CGSizeMake(maxWidth, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil) as CGRect
        return rect.size
    }
    public func toast(target: UIViewController){
        if text != "" {
            var textAreaWidth =  self.width - 20
            var imageToasterHeight:CGFloat = 0
            var textXPos:CGFloat = 10
            
            if self.iconImage != nil || (self.iconURL != nil && self.iconURL != ""){
                imageToasterHeight = self.iconSquareSize + self.statusBarHeight + 20
                textAreaWidth -= (self.iconSquareSize + 5)
                self.textAlignment = NSTextAlignment.Left
                textXPos += self.iconSquareSize + 5
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
            
            let toasterView = UIView(frame: toasterViewFrame)
            toasterView.userInteractionEnabled = false
            toasterView.backgroundColor = self.backgroundColor
            
            if self.iconImage != nil || (self.iconURL != nil && self.iconURL != ""){
                let iconView = UIImageView(frame: CGRectMake(10, yPos, self.iconSquareSize, self.iconSquareSize))
                iconView.backgroundColor = self.iconBackgroundColor
                iconView.layer.cornerRadius = self.iconCornerRadius
                iconView.clipsToBounds = true
                
                if self.iconImage != nil {
                    iconView.image = self.iconImage
                }
                if self.iconURL != nil && self.iconURL != "" {
                    QToasterSwift.imageForUrl(self.iconURL!, completionHandler:{(image: UIImage?, url: String) in
                        iconView.image = image
                    })
                }
                toasterView.addSubview(iconView)
            }
            
            if self.titleText != nil && self.titleText != "" {
                let titleLabel = UILabel(frame: CGRectMake(textXPos, yPos, textAreaWidth, self.titleSize.height))
                titleLabel.numberOfLines = 0
                titleLabel.textAlignment = self.textAlignment
                titleLabel.text = self.titleText
                titleLabel.textColor = self.textColor
                titleLabel.font = self.titleFont
                toasterView.addSubview(titleLabel)
                yPos += 3 + self.titleSize.height
            }else{
                yPos = ((toasterHeight - self.textSize.height) / 2) + 10
            }
            
            let textLabel = UILabel(frame: CGRectMake(textXPos, yPos, textAreaWidth, self.textSize.height))
            textLabel.text = self.text
            textLabel.textAlignment = self.textAlignment
            textLabel.textColor = self.textColor
            textLabel.numberOfLines = 0
            textLabel.font = self.textFont
            toasterView.addSubview(textLabel)
            
            let toastButton = UIButton(frame: CGRectMake(0, 0, self.width, toasterHeight))
            toastButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            toastButton.addTarget(self, action: "touchAction", forControlEvents: UIControlEvents.TouchUpInside)
            toastButton.addSubview(toasterView)
            
            target.navigationController?.view.addSubview(toastButton)
            target.navigationController?.view.userInteractionEnabled = true
            
            
            UIView.animateWithDuration(self.animateDuration, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                let showFrame = CGRectMake(0,0,self.width,toasterHeight)
                toasterView.frame = showFrame
                }, completion: { _ in
                    UIView.animateWithDuration(self.animateDuration, delay: self.delayDuration, options: UIViewAnimationOptions.AllowUserInteraction,
                        animations: {
                            let hideFrame = CGRectMake(0,0 - toasterHeight,self.width,toasterHeight)
                            toasterView.frame = hideFrame
                        },
                        completion: { _ in
                            toasterView.removeFromSuperview()
                            toastButton.removeFromSuperview()
                        }
                    )
                }
            )
            
        }
    }
    public class func toast(target: UIViewController, text: String, title:String? = nil, iconURL:String? = nil, iconPlaceHolder:UIImage? = nil, backgroundColor:UIColor? = nil, textColor:UIColor? = nil, onTouch: ()->Void = ({})){
        if text != "" {
            let toaster = QToasterSwift()
            toaster.text = text
            toaster.titleText = title
            toaster.iconURL = iconURL
            toaster.iconImage = iconPlaceHolder
            toaster.toastAction = onTouch
            
            if backgroundColor != nil {
                toaster.backgroundColor = backgroundColor!
            }
            if textColor != nil {
                toaster.textColor = textColor!
            }
            
            var textAreaWidth =  toaster.width - 20
            var imageToasterHeight:CGFloat = 0
            var textXPos:CGFloat = 10
            
            if toaster.iconImage != nil || (toaster.iconURL != nil && toaster.iconURL != ""){
                imageToasterHeight = toaster.iconSquareSize + toaster.statusBarHeight + 20
                textAreaWidth -= (toaster.iconSquareSize + 5)
                toaster.textAlignment = NSTextAlignment.Left
                textXPos += toaster.iconSquareSize + 5
            }
            
            var toasterHeight = toaster.textSize.height + toaster.titleSize.height + toaster.statusBarHeight + 20
            if toaster.titleSize.height > 0 {
                toasterHeight += 3
            }
            if toasterHeight < toaster.minHeight {
                toasterHeight = toaster.minHeight
            }
            
            if toasterHeight < imageToasterHeight{
                toasterHeight = imageToasterHeight
            }
            
            
            var yPos:CGFloat = toaster.statusBarHeight + 10
            
            let toasterViewFrame = CGRectMake(0,0 - toasterHeight, toaster.width,toasterHeight)
            
            let toasterView = UIView(frame: toasterViewFrame)
            toasterView.userInteractionEnabled = false
            toasterView.backgroundColor = toaster.backgroundColor
            
            if toaster.iconImage != nil || (toaster.iconURL != nil && toaster.iconURL != ""){
                let iconView = UIImageView(frame: CGRectMake(10, yPos, toaster.iconSquareSize, toaster.iconSquareSize))
                iconView.backgroundColor = toaster.iconBackgroundColor
                iconView.layer.cornerRadius = toaster.iconCornerRadius
                iconView.clipsToBounds = true
                
                if toaster.iconImage != nil {
                    iconView.image = toaster.iconImage
                }
                if toaster.iconURL != nil && toaster.iconURL != "" {
                    QToasterSwift.imageForUrl(toaster.iconURL!, completionHandler:{(image: UIImage?, url: String) in
                        iconView.image = image
                    })
                }
                toasterView.addSubview(iconView)
            }
            
            if toaster.titleText != nil && toaster.titleText != "" {
                let titleLabel = UILabel(frame: CGRectMake(textXPos, yPos, textAreaWidth, toaster.titleSize.height))
                titleLabel.numberOfLines = 0
                titleLabel.textAlignment = toaster.textAlignment
                titleLabel.text = toaster.titleText
                titleLabel.textColor = toaster.textColor
                titleLabel.font = toaster.titleFont
                toasterView.addSubview(titleLabel)
                yPos += 3 + toaster.titleSize.height
            }else{
                yPos = ((toasterHeight - toaster.textSize.height) / 2) + 10
            }
            
            let textLabel = UILabel(frame: CGRectMake(textXPos, yPos, textAreaWidth, toaster.textSize.height))
            textLabel.text = toaster.text
            textLabel.textAlignment = toaster.textAlignment
            textLabel.textColor = toaster.textColor
            textLabel.numberOfLines = 0
            textLabel.font = toaster.textFont
            toasterView.addSubview(textLabel)
            
            let toastButton = UIButton(frame: CGRectMake(0, 0, toaster.width, toasterHeight))
            toastButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            toastButton.addTarget(self, action: "touchAction", forControlEvents: UIControlEvents.TouchUpInside)
            toastButton.addSubview(toasterView)
            
            target.navigationController?.view.addSubview(toastButton)
            target.navigationController?.view.userInteractionEnabled = true
            
            
            UIView.animateWithDuration(toaster.animateDuration, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    let showFrame = CGRectMake(0,0,toaster.width,toasterHeight)
                    toasterView.frame = showFrame
                }, completion: { _ in
                    UIView.animateWithDuration(toaster.animateDuration, delay: toaster.delayDuration, options: UIViewAnimationOptions.AllowUserInteraction,
                        animations: {
                            let hideFrame = CGRectMake(0,0 - toasterHeight,toaster.width,toasterHeight)
                            toasterView.frame = hideFrame
                        },
                        completion: { _ in
                            toasterView.removeFromSuperview()
                            toastButton.removeFromSuperview()
                        }
                    )
                }
            )
            
        }
    }
    public class func toastWithIcon(target: UIViewController, text: String, icon:UIImage?, title:String? = nil, backgroundColor:UIColor? = nil, textColor:UIColor? = nil, onTouch: ()->Void = ({})){
        if text != "" {
            let toaster = QToasterSwift()
            toaster.text = text
            toaster.titleText = title
            toaster.iconImage = icon
            toaster.toastAction = onTouch
            
            if backgroundColor != nil {
                toaster.backgroundColor = backgroundColor!
            }
            if textColor != nil {
                toaster.textColor = textColor!
            }
            
            var textAreaWidth =  toaster.width - 20
            var imageToasterHeight:CGFloat = 0
            var textXPos:CGFloat = 10
            
            if toaster.iconImage != nil || (toaster.iconURL != nil && toaster.iconURL != ""){
                imageToasterHeight = toaster.iconSquareSize + toaster.statusBarHeight + 20
                textAreaWidth -= (toaster.iconSquareSize + 5)
                toaster.textAlignment = NSTextAlignment.Left
                textXPos += toaster.iconSquareSize + 5
            }
            
            var toasterHeight = toaster.textSize.height + toaster.titleSize.height + toaster.statusBarHeight + 20
            if toaster.titleSize.height > 0 {
                toasterHeight += 3
            }
            if toasterHeight < toaster.minHeight {
                toasterHeight = toaster.minHeight
            }
            
            if toasterHeight < imageToasterHeight{
                toasterHeight = imageToasterHeight
            }
            
            
            var yPos:CGFloat = toaster.statusBarHeight + 10
            
            let toasterViewFrame = CGRectMake(0,0 - toasterHeight, toaster.width,toasterHeight)
            
            let toasterView = UIView(frame: toasterViewFrame)
            toasterView.userInteractionEnabled = false
            toasterView.backgroundColor = toaster.backgroundColor
            
            if toaster.iconImage != nil || (toaster.iconURL != nil && toaster.iconURL != ""){
                let iconView = UIImageView(frame: CGRectMake(10, yPos, toaster.iconSquareSize, toaster.iconSquareSize))
                iconView.backgroundColor = toaster.iconBackgroundColor
                iconView.layer.cornerRadius = toaster.iconCornerRadius
                iconView.clipsToBounds = true
                
                if toaster.iconImage != nil {
                    iconView.image = toaster.iconImage
                }
                if toaster.iconURL != nil && toaster.iconURL != "" {
                    QToasterSwift.imageForUrl(toaster.iconURL!, completionHandler:{(image: UIImage?, url: String) in
                        iconView.image = image
                    })
                }
                toasterView.addSubview(iconView)
            }
            
            if toaster.titleText != nil && toaster.titleText != "" {
                let titleLabel = UILabel(frame: CGRectMake(textXPos, yPos, textAreaWidth, toaster.titleSize.height))
                titleLabel.numberOfLines = 0
                titleLabel.textAlignment = toaster.textAlignment
                titleLabel.text = toaster.titleText
                titleLabel.textColor = toaster.textColor
                titleLabel.font = toaster.titleFont
                toasterView.addSubview(titleLabel)
                yPos += 3 + toaster.titleSize.height
            }else{
                yPos = ((toasterHeight - toaster.textSize.height) / 2) + 10
            }
            
            let textLabel = UILabel(frame: CGRectMake(textXPos, yPos, textAreaWidth, toaster.textSize.height))
            textLabel.text = toaster.text
            textLabel.textAlignment = toaster.textAlignment
            textLabel.textColor = toaster.textColor
            textLabel.numberOfLines = 0
            textLabel.font = toaster.textFont
            toasterView.addSubview(textLabel)
            
            let toastButton = UIButton(frame: CGRectMake(0, 0, toaster.width, toasterHeight))
            toastButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            toastButton.addTarget(self, action: "touchAction", forControlEvents: UIControlEvents.TouchUpInside)
            toastButton.addSubview(toasterView)
            
            target.navigationController?.view.addSubview(toastButton)
            target.navigationController?.view.userInteractionEnabled = true
            
            
            UIView.animateWithDuration(toaster.animateDuration, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                let showFrame = CGRectMake(0,0,toaster.width,toasterHeight)
                toasterView.frame = showFrame
                }, completion: { _ in
                    UIView.animateWithDuration(toaster.animateDuration, delay: toaster.delayDuration, options: UIViewAnimationOptions.AllowUserInteraction,
                        animations: {
                            let hideFrame = CGRectMake(0,0 - toasterHeight,toaster.width,toasterHeight)
                            toasterView.frame = hideFrame
                        },
                        completion: { _ in
                            toasterView.removeFromSuperview()
                            toastButton.removeFromSuperview()
                        }
                    )
                }
            )
            
        }
    }
    public func toast(target: UIViewController, text: String, title:String? = nil){
        if self.text != "" {
            print("toast inside Class")
        }
    }
    
    public func touchAction(){
        print("test QToaster")
        self.toastAction()
    }
    public func addAction(action:()->Void){
        self.toastAction = action
    }
    
    //  func imageForUrl
    //  taken from : ImageLoader.swift
    //  extension
    //
    //  Created by Nate Lyman on 7/5/14.
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
