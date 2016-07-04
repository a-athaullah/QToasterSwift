//
//  QToasterSwift.swift
//  QToasterSwift
//
//  Created by Ahmad Athaullah on 6/30/16.
//  Copyright © 2016 Ahmad Athaullah. All rights reserved.
//

import UIKit

public class QToasterSwift: NSObject {
    /**
     On touch action for your toaster
     Default value: empty Void
    */
    public var toastAction:()->Void = ({})
    
    /**
     The alignment of text inside your toaster
     Default value: NSTextAlignment.Center
    */
    public var textAlignment:NSTextAlignment = NSTextAlignment.Center
    
    /**
     Font type used for toaster title
     Default value: UIFont.systemFontOfSize(11.0, weight: 0.8)
    */
    public var titleFont = QToasterConfig.titleFont
    
    /**
     Font type used for toaster text
     Default value: UIFont.systemFontOfSize(11.0)
    */
    public var textFont = QToasterConfig.textFont
    
    
    /**
     Your toaster title, can be nil
     Default value: nil
    */
    public var titleText:String?
    
    /**
     Your toaster message
     Default value : "" (empty string)
    */
    public var text:String = ""
    
    /**
     Your toaster icon, can be nil
     Default value : nil
    */
    public var iconImage:UIImage?
    
    /**
     Your toaster url icon, can be nil
     Default value : nil
     */
    public var iconURL:String?
    
    public var backgroundColor = QToasterConfig.backgroundColor
    public var textColor = QToasterConfig.textColor
    public var animateDuration = QToasterConfig.animateDuration
    public var delayDuration = QToasterConfig.delayDuration
    
    public var iconSquareSize = QToasterConfig.iconSquareSize
    public var iconCornerRadius = QToasterConfig.iconCornerRadius
    public var iconBackgroundColor = QToasterConfig.iconBackgroundColor
    

    public func toast(target: UIViewController, onTouch:()->Void = ({})){
        if text != "" {
            self.addAction(onTouch)
            
            if let previousToast = QToasterSwift.otherToastExist(target){
                previousToast.removeFromSuperview()
            }
            
            let toasterView = QToasterView()
            toasterView.setupToasterView(self)
            
            var previousToast: QToasterView?
            if let lastToast = QToasterSwift.otherToastExist(target){
                previousToast = lastToast
            }
            
            target.navigationController?.view.addSubview(toasterView)
            target.navigationController?.view.userInteractionEnabled = true
            
            if previousToast != nil {
                previousToast?.hide({
                    toasterView.show()
                })
            }else{
                toasterView.show()
            }
            
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
            
            var previousToast: QToasterView?
            if let lastToast = QToasterSwift.otherToastExist(target){
                previousToast = lastToast
            }
            
            let toastButton = QToasterView()
            toastButton.setupToasterView(toaster)
            
            target.navigationController?.view.addSubview(toastButton)
            target.navigationController?.view.userInteractionEnabled = true
            
            if previousToast != nil {
                previousToast?.hide({
                    toastButton.show()
                })
            }else{
                toastButton.show()
            }
        }
    }
    public class func toastWithIcon(target: UIViewController, text: String, icon:UIImage?, title:String? = nil, backgroundColor:UIColor? = nil, textColor:UIColor? = nil, onTouch: ()->Void = ({})){
        if text != "" {
            let toaster = QToasterSwift()
            toaster.text = text
            toaster.titleText = title
            toaster.iconImage = icon
            toaster.toastAction = onTouch
            
            var previousToast: QToasterView?
            
            if backgroundColor != nil {
                toaster.backgroundColor = backgroundColor!
            }
            if textColor != nil {
                toaster.textColor = textColor!
            }
            
            if let lastToast = QToasterSwift.otherToastExist(target){
                previousToast = lastToast
            }
            
            let toastButton = QToasterView()
            toastButton.setupToasterView(toaster)
            
            target.navigationController?.view.addSubview(toastButton)
            target.navigationController?.view.userInteractionEnabled = true
            
            if previousToast != nil {
                previousToast?.hide({ 
                    toastButton.show()
                })
            }else{
                toastButton.show()
            }
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
