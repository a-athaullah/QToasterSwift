//
//  ViewController.swift
//  Example
//
//  Created by Ahmad Athaullah on 6/30/16.
//  Copyright © 2016 Ahmad Athaullah. All rights reserved.
//

import UIKit
import QToasterSwift

class ViewController: UIViewController {
    
    
    let baseColor = UIColor(red: 51/255.0, green: 204/255.0, blue: 51/255.0, alpha: 1)
    let errorColor = UIColor(red: 1, green: 80/255, blue: 80/255.0, alpha: 0.9)
    let lightGray = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    let darkGray = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
    
    let titleField = UITextField()
    let messageField = UITextView()
    let urlField = UITextField()
    
    let errorText = "For this Demo App, at least you have message to show. otherwise we will show error toaster with non-default toaster background color."
    
    
    var screenWidth:CGFloat{
        get{
            return UIScreen.main.bounds.size.width
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "QToasterSwift Demo"
        
        let titleLabel = UILabel(frame: CGRect(x: 20,y: 20,width: 60,height: 30))
        titleLabel.text = "Title"
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: 0.5)
        self.view.addSubview(titleLabel)
        
        titleField.frame = CGRect(x: 90,y: 20,width: screenWidth - 110,height: 30)
        titleField.placeholder = "Toaster title here ..."
        titleField.layer.cornerRadius = 4
        titleField.layer.borderColor = darkGray.cgColor
        titleField.backgroundColor = lightGray
        titleField.font = UIFont.systemFont(ofSize: 12, weight: 0.3)
        self.view.addSubview(titleField)
        
        let messageLabel = UILabel(frame: CGRect(x: 20,y: 60,width: 60,height: 30))
        messageLabel.text = "Message"
        messageLabel.font = UIFont.systemFont(ofSize: 13, weight: 0.5)
        self.view.addSubview(messageLabel)
        
        messageField.frame = CGRect(x: 90,y: 60,width: screenWidth - 110,height: 60)
        messageField.isEditable = true
        messageField.allowsEditingTextAttributes = false
        messageField.layer.cornerRadius = 4
        messageField.layer.borderColor = darkGray.cgColor
        messageField.backgroundColor = lightGray
        messageField.font = UIFont.systemFont(ofSize: 12, weight: 0.3)
        self.view.addSubview(messageField)
        
        
        let urlLabel = UILabel(frame: CGRect(x: 20,y: 130,width: 60,height: 30))
        urlLabel.text = "Icon URL"
        urlLabel.font = UIFont.systemFont(ofSize: 13, weight: 0.5)
        self.view.addSubview(urlLabel)
        
        urlField.frame = CGRect(x: 90,y: 130,width: screenWidth - 110,height: 30)
        urlField.placeholder = "Icon URL here ..."
        urlField.layer.cornerRadius = 4
        urlField.layer.borderColor = darkGray.cgColor
        urlField.backgroundColor = lightGray
        urlField.font = UIFont.systemFont(ofSize: 12, weight: 0.3)
        urlField.text = "https://qiscuss3.s3.amazonaws.com/uploads/db5cbfe427dbeca6026d57c047074866/Screenshot_2015-02-19-12-09-15-1.png"
        self.view.addSubview(urlField)
        
        let button1 = UIButton(frame: CGRect(x: 20, y: 180, width: screenWidth - 40, height: 30))
        button1.setTitle("Show Toaster", for: UIControlState())
        button1.backgroundColor = baseColor
        button1.layer.cornerRadius = 4
        button1.addTarget(self, action: #selector(ViewController.toaster1), for: UIControlEvents.touchUpInside)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 12.5, weight: 0.4)
        self.view.addSubview(button1)
        
        let button2 = UIButton(frame: CGRect(x: 20, y: 220, width: screenWidth - 40, height: 30))
        button2.setTitle("Show Toaster With Icon", for: UIControlState())
        button2.backgroundColor = baseColor
        button2.layer.cornerRadius = 4
        button2.addTarget(self, action: #selector(ViewController.toaster2), for: UIControlEvents.touchUpInside)
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 12.5, weight: 0.4)
        self.view.addSubview(button2)
        
        let button3 = UIButton(frame: CGRect(x: 20, y: 260, width: screenWidth - 40, height: 30))
        button3.setTitle("Show Toaster With Icon From URL", for: UIControlState())
        button3.backgroundColor = baseColor
        button3.layer.cornerRadius = 4
        button3.addTarget(self, action: #selector(ViewController.toaster3), for: UIControlEvents.touchUpInside)
        button3.titleLabel?.font = UIFont.systemFont(ofSize: 12.5, weight: 0.4)
        self.view.addSubview(button3)
        
        let infoLabel = UILabel(frame: CGRect(x: 20, y: 400, width: screenWidth - 40, height: 60))
        infoLabel.text = "This Demo App only support secure image URL (with https protocol), if you need to load from non secure URL you need to whitelist that URL in your plist.info file"
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = NSTextAlignment.center
        infoLabel.font = UIFont.systemFont(ofSize: 11, weight: 0.6)
        infoLabel.textColor = darkGray
        self.view.addSubview(infoLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func toaster1(){
        if messageField.text != nil && messageField.text != "" {
            QToasterSwift.toast(self, text: messageField.text, title: titleField.text)
        }else{
            QToasterSwift.toast(self, text: errorText, title: "ERROR", backgroundColor: errorColor)
        }
    }
    func toaster2(){
        if messageField.text != nil && messageField.text != "" {
            QToasterSwift.toastWithIcon(self, text: messageField.text, icon: UIImage(named: "avatar"), title: titleField.text)
        }else{
            QToasterSwift.toast(self, text: errorText, title: "ERROR", backgroundColor: errorColor)
        }
    }
    func toaster3(){
        if messageField.text != nil && messageField.text != "" {
            QToasterSwift.toast(self, text: messageField.text, title: titleField.text, iconURL: urlField.text, iconPlaceHolder: UIImage(named: "avatar"),onTouch:{
                print("working")
            })
        }else{
            QToasterSwift.toast(self, text: errorText, title: "ERROR", backgroundColor: errorColor)
        }
    }
}

