//
//  QToasterSwift.swift
//  QToasterSwift
//
//  Created by Ahmad Athaullah on 6/30/16.
//  Copyright © 2016 Ahmad Athaullah. All rights reserved.
//

import UIKit

public class QToasterSwift: NSObject {

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
    

    public func toast(target: UIViewController, onTouch:()->Void = ({})){
        if text != "" {
            self.addAction(onTouch)
            
            if let previousToast = QToasterSwift.otherToastExist(target){
                previousToast.removeFromSuperview()
            }
            
            let toasterView = QToasterView()
            toasterView.setupToasterView(self)
            
            let screenWidth = UIScreen.mainScreen().bounds.size.width
            
            target.navigationController?.view.addSubview(toasterView)
            target.navigationController?.view.userInteractionEnabled = true
            
            
            UIView.animateWithDuration(self.animateDuration, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                let showFrame = CGRectMake(0,0,screenWidth,toasterView.frame.height)
                toasterView.viewArea.frame = showFrame
                }, completion: { _ in
                    UIView.animateWithDuration(self.animateDuration, delay: self.delayDuration, options: UIViewAnimationOptions.AllowUserInteraction,
                        animations: {
                            let hideFrame = CGRectMake(0,0 - toasterView.frame.height,screenWidth,toasterView.frame.height)
                            toasterView.frame = hideFrame
                        },
                        completion: { _ in
                            toasterView.removeFromSuperview()
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
            
            if let previousToast = QToasterSwift.otherToastExist(target){
                previousToast.removeFromSuperview()
            }
            
            let toastButton = QToasterView()
            toastButton.setupToasterView(toaster)
            
            target.navigationController?.view.addSubview(toastButton)
            target.navigationController?.view.userInteractionEnabled = true
            
            let screenWidth = UIScreen.mainScreen().bounds.size.width
            
            UIView.animateWithDuration(toaster.animateDuration, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                    let showFrame = CGRectMake(0,0,screenWidth,toastButton.frame.height)
                    toastButton.viewArea.frame = showFrame
                }, completion: { _ in
                    UIView.animateWithDuration(toaster.animateDuration, delay: toaster.delayDuration, options: UIViewAnimationOptions.AllowUserInteraction,
                        animations: {
                            let hideFrame = CGRectMake(0,0 - toastButton.frame.height,screenWidth,toastButton.frame.height)
                            toastButton.viewArea.frame = hideFrame
                        },
                        completion: { _ in
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
            
            if let previousToast = QToasterSwift.otherToastExist(target){
                previousToast.removeFromSuperview()
            }
            
            let toastButton = QToasterView()
            toastButton.setupToasterView(toaster)
            
            target.navigationController?.view.addSubview(toastButton)
            target.navigationController?.view.userInteractionEnabled = true
            
            let screenWidth = UIScreen.mainScreen().bounds.size.width
            
            UIView.animateWithDuration(toaster.animateDuration, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                let showFrame = CGRectMake(0,0,screenWidth,toastButton.frame.height)
                toastButton.viewArea.frame = showFrame
                }, completion: { _ in
                    UIView.animateWithDuration(toaster.animateDuration, delay: toaster.delayDuration, options: UIViewAnimationOptions.AllowUserInteraction,
                        animations: {
                            let hideFrame = CGRectMake(0,0 - toastButton.frame.height,screenWidth, toastButton.frame.height)
                            toastButton.viewArea.frame = hideFrame
                        },
                        completion: { _ in
                            toastButton.removeFromSuperview()
                        }
                    )
                }
            )
            
        }
    }
    class func otherToastExist(target: UIViewController) -> QToasterView?{
        if let toaster = target.navigationController?.view.viewWithTag(1313) as? QToasterView {
            return toaster
        }else{
            return nil
        }
    }
    public func touchAction(){
        self.toastAction()
    }
    public func addAction(action:()->Void){
        self.toastAction = action
    }
    
}
