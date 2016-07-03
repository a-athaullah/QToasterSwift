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
    public var textFont = QToasterConfig.textFont
    public var titleFont = QToasterConfig.titleFont
    
    public var titleText:String?
    public var text:String = ""
    public var iconImage:UIImage?
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
