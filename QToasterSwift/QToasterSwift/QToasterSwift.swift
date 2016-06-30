//
//  QToasterSwift.swift
//  QToasterSwift
//
//  Created by Ahmad Athaullah on 6/30/16.
//  Copyright © 2016 Ahmad Athaullah. All rights reserved.
//

import UIKit
import AlamofireImage

public class QToasterSwift: UIView {
    
    public var toastAction:()->Void = ({})
    public var toastFont = UIFont.systemFontOfSize(11.0)
    public var titleFont = UIFont.systemFontOfSize(11.0)
    
    func textSize(text: NSString, font: UIFont, maxWidth: CGFloat)->CGSize{
        let rect = text.boundingRectWithSize(CGSizeMake(maxWidth, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil) as CGRect
        return rect.size
    }
    public func toastMessage(message:String, viewController:UIViewController, title:String? = nil, backgroundColor:UIColor? = nil, textColor:UIColor? = nil, imagePlaceHolder:UIImage? = nil, imageURL:String? = nil){
        
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        let toastWidth:CGFloat = UIScreen.mainScreen().bounds.size.width
        
        var textWidth:CGFloat = toastWidth - 20
        
        if imagePlaceHolder != nil || imageURL != nil{
            textWidth -= 45
        }
        var titleText:String = ""
        if  title != nil && title != "" {
            titleText = title!
        }
        let titleHeight = self.textSize(titleText, font: titleFont, maxWidth: textWidth).height
        
        let textHeight:CGFloat = textSize(message, font: toastFont, maxWidth: textWidth).height
        var toastHeight:CGFloat = textHeight + 20 + statusBarHeight
        if imagePlaceHolder != nil || imageURL != nil{
            toastHeight = 50 + statusBarHeight
            if (textHeight + titleHeight + 1) > 30 {
                toastHeight = textHeight + 21 + statusBarHeight + titleHeight
            }
        }
        
        var labelFrame = CGRectMake(10, 10 + statusBarHeight, textWidth, textHeight)
        if imagePlaceHolder != nil || imageURL != nil{
            labelFrame = CGRectMake(45, 10 + statusBarHeight, textWidth, textHeight)
        }
        
        var titleLabel = UILabel()
        var toasterFrame = CGRectMake(0,0 - textHeight,toastWidth,toastHeight)
        var buttonFrame = CGRectMake(0,0,toastWidth,toastHeight)
        // setup title if exist
        if title != nil && title != "" {
            let titleFrame = CGRectMake(labelFrame.origin.x, 10 + statusBarHeight, textWidth, titleHeight)
            
            titleLabel = UILabel(frame: titleFrame)
            titleLabel.font = titleFont
            titleLabel.textAlignment = NSTextAlignment.Left
            titleLabel.text = title
            titleLabel.textColor = UIColor.blackColor()
            titleLabel.userInteractionEnabled = false
            labelFrame.origin.y += titleHeight + 1
            toasterFrame.size.height += titleHeight + 1
            buttonFrame.size.height += titleHeight + 1
        }
        
        self.frame = toasterFrame
        self.userInteractionEnabled = false
        
        let toastButton = UIButton(frame: buttonFrame)
        toastButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        if backgroundColor != nil {
            self.backgroundColor = backgroundColor
        }else{
            self.backgroundColor = UIColor.whiteColor()
        }
        if title != nil && title != "" {
            self.addSubview(titleLabel)
        }
        let messageLabel = UILabel(frame: labelFrame)
        messageLabel.font = toastFont
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        messageLabel.textColor = UIColor.blackColor()
        messageLabel.userInteractionEnabled = false
        if textColor != nil {
            messageLabel.textColor = textColor!
            titleLabel.textColor = textColor!
        }
        messageLabel.textAlignment = NSTextAlignment.Left
        
        self.addSubview(messageLabel)
        
        if imagePlaceHolder != nil || imageURL != nil{
            let iconView = UIImageView(frame: CGRectMake(10, 10 + statusBarHeight, 30, 30))
            iconView.layer.cornerRadius = 5
            iconView.clipsToBounds = true
            if imageURL != nil && imageURL != ""{
                iconView.af_setImageWithURL(NSURL(string: imageURL!)!, placeholderImage: imagePlaceHolder)
            }else{
                iconView.image = imagePlaceHolder
            }
            iconView.contentMode = UIViewContentMode.ScaleAspectFill
            iconView.userInteractionEnabled = false
            self.addSubview(iconView)
        }
        viewController.navigationController.view.addSubview(toastButton)
        toastButton.addSubview(self)
        
        viewController.navigationController.view.userInteractionEnabled = true
        toastButton.addTarget(self, action: "touchAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction,
                                   animations: {
                                    let showFrame = CGRectMake(0,0,toastWidth,toastHeight)
                                    self.frame = showFrame
            },
                                   completion: { _ in
                                    UIView.animateWithDuration(0.1, delay: 4.0, options: UIViewAnimationOptions.AllowUserInteraction,
                                        animations: {
                                            let hideFrame = CGRectMake(0,0 - toastHeight,toastWidth,toastHeight)
                                            self.frame = hideFrame
                                        },
                                        completion: { _ in
                                            self.removeFromSuperview()
                                            toastButton.removeFromSuperview()
                                        }
                                    )
            }
        )
    }
    
    public func touchAction(){
        print("test QToaster")
        self.toastAction()
    }
    public func addAction(action:()->Void){
        self.toastAction = action
    }
}
