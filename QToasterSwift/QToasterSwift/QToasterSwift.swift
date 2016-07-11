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
     On touch action for your toaster, Default value: empty Void
    */
    public var toastAction:()->Void = ({})
    
    /**
     The alignment of text inside your toaster, Default value: NSTextAlignment.Center
    */
    public var textAlignment:NSTextAlignment = NSTextAlignment.Center
    
    /**
     Font type used for toaster title, Default value: UIFont.systemFontOfSize(11.0, weight: 0.8)
    */
    public var titleFont = QToasterConfig.titleFont
    
    /**
     Font type used for toaster text, Default value: UIFont.systemFontOfSize(11.0)
    */
    public var textFont = QToasterConfig.textFont
    
    /**
     Your toaster title, can be nil, Default value: nil
    */
    public var titleText:String?
    
    /**
     Your toaster message, Default value : "" (empty string)
    */
    public var text:String = ""
    
    /**
     Your toaster icon, can be nil, Default value : nil
    */
    public var iconImage:UIImage?
    
    /**
     Your toaster url icon, can be nil, Default value : nil
     */
    public var iconURL:String?
    
    /**
     Your toaster background color, Default value : UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
     */
    public var backgroundColor = QToasterConfig.backgroundColor
    
    /**
     Your toaster background color, Default value : UIColor.whiteColor()
     */
    public var textColor = QToasterConfig.textColor
    
    /**
     Your toaster animation duration using NSTimeInterval class, Default value : 0.2
     */
    public var animateDuration = QToasterConfig.animateDuration
    
    /**
     Your toaster delay duration before start to disappar, using NSTimeInterval class, Default value : 3.0
     */
    public var delayDuration = QToasterConfig.delayDuration
    
    /**
     Your toaster badge size (always square), using CGFloat class, Default value : 35.0
     */
    public var iconSquareSize = QToasterConfig.iconSquareSize
    
    /**
     Your toaster badge corner radius, using CGFloat class, if you want to set circle badge, just set it to half of your icon SquareSize
     Default value : 3.0
     */
    public var iconCornerRadius = QToasterConfig.iconCornerRadius
    
    /**
     Your toaster badge background color, using UIColor class,
     can only shown when using icon badge url without placeholder image
     Default value : UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
     */
    public var iconBackgroundColor = QToasterConfig.iconBackgroundColor
    
    /**
     Toast message inside your **QToasterSwift** object
     
     - Parameter target:   The **UIViewController** where toaster will appear
     - Parameter onTouch:  **()->Void** as onTouch action for your toaster
     */
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
    /**
     Class function to show toaster with configuration and without initiation.
     - parameter target: The **UIViewController** where toaster will appear.
     - parameter text: **String** message to show in toaster.
     - parameter title: **String** text to show as toaster title.
     - parameter iconURL: **String** URL of your icon toaster.
     - parameter iconPlaceHolder: **UIImage** to show as icon toaster when loading iconURL.
     - parameter backgroundColor: the **UIColor** as your toaster background color.
     - parameter textColor: the **UIColor** as your toaster text color.
     - parameter onTouch: **()->Void** as onTouch action for your toaster.
     */
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
    /**
     Class function to show toaster with badge icon
     - parameter target: The **UIViewController** where toaster will appear.
     - parameter text: **String** message to show in toaster.
     - parameter title: **String** text to show as toaster title.
     - parameter icon: **UIImage** to show as badge icon toaster.
     - parameter backgroundColor: the **UIColor** as your toaster background color.
     - parameter textColor: the **UIColor** as your toaster text color.
     - parameter onTouch: **()->Void** as onTouch action for your toaster.
     */
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
    /**
     Private methode executed on QToaster onTouch
     */
    func touchAction(){ self.toastAction() }
    /**
     Add onTouch action to QToaster
     - parameter action: **()->Void** as onTouch action for your toaster.
     */
    public func addAction(action:()->Void){ self.toastAction = action }
    /**
     Private function helper to check if other QToaster is shown
     - parameter target: The **UIViewController** to check.
     - returns: **QToasterView** object if QToaster is exist and nil if not.
     */
    class func otherToastExist(target: UIViewController) -> QToasterView?{
        return target.navigationController?.view.viewWithTag(1313) as? QToasterView
    }
}
