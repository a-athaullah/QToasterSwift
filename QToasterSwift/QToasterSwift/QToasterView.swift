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
        return QToasterConfig.statusBarHeight + 40
    }
    var textSize:CGSize{
        if toaster.iconImage == nil && (toaster.iconURL == nil || toaster.iconURL == "") {
            return QToasterConfig.textSize(toaster.text, font: toaster.textFont, maxWidth: QToasterConfig.screenWidth)
        }else{
            return QToasterConfig.textSize(toaster.text, font: toaster.textFont, maxWidth: QToasterConfig.screenWidth - toaster.iconSquareSize - 25)
        }
    }
    var titleSize:CGSize{
        if toaster.titleText != nil && toaster.titleText != ""{
            if toaster.iconImage == nil && (toaster.iconURL == nil || toaster.iconURL == "") {
                return QToasterConfig.textSize(toaster.titleText!, font: toaster.textFont, maxWidth: QToasterConfig.screenWidth - 20)
            }else{
                return QToasterConfig.textSize(toaster.titleText!, font: toaster.textFont, maxWidth: QToasterConfig.screenWidth -  toaster.iconSquareSize - 25)
            }
        }else{
            return CGSizeMake(0, 0)
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
        self.layer.zPosition = 9999
    }
    
    
    func setupToasterView(toaster: QToasterSwift){
        self.toaster = toaster
        
        var textAreaWidth =  QToasterConfig.screenWidth - 20
        var imageToasterHeight:CGFloat = 0
        var textXPos:CGFloat = 10
        
        if toaster.iconImage != nil || (toaster.iconURL != nil && toaster.iconURL != ""){
            imageToasterHeight = toaster.iconSquareSize + QToasterConfig.statusBarHeight + 20
            textAreaWidth -= (toaster.iconSquareSize + 5)
            toaster.textAlignment = NSTextAlignment.Left
            textXPos += toaster.iconSquareSize + 5
        }
        
        var toasterHeight = self.textSize.height + self.titleSize.height + QToasterConfig.statusBarHeight + 20
        if self.titleSize.height > 0 {
            toasterHeight += 3
        }
        if toasterHeight < self.minHeight {
            toasterHeight = self.minHeight
        }
        
        if toasterHeight < imageToasterHeight{
            toasterHeight = imageToasterHeight
        }
        
        
        var yPos:CGFloat = QToasterConfig.statusBarHeight + 10
        
        let toasterViewFrame = CGRectMake(0,0 - toasterHeight, QToasterConfig.screenWidth,toasterHeight)
        
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
                QToasterConfig.imageForUrl(toaster.iconURL!, completionHandler:{(image: UIImage?, url: String) in
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
        
        self.frame = CGRectMake(0, 0, QToasterConfig.screenWidth, toasterHeight)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.addTarget(self, action: #selector(self.toaster.touchAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(viewArea)
    }
    
    
    func show(){
        UIView.animateWithDuration(self.toaster.animateDuration, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            let showFrame = CGRectMake(0,0,QToasterConfig.screenWidth,self.frame.height)
            self.viewArea.frame = showFrame
            }, completion: { _ in
                self.hide()
            }
        )
        
    }
    func hide(completion: () -> Void = ({})){
        UIView.animateWithDuration(self.toaster.animateDuration, delay: self.toaster.delayDuration, options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                let hideFrame = CGRectMake(0,0 - self.frame.height,QToasterConfig.screenWidth,self.frame.height)
                self.frame = hideFrame
            },
            completion: { _ in
                self.removeFromSuperview()
                completion()
            }
        )
    }
}
