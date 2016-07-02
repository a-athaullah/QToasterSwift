# QToasterSwift
[![CocoaPods](https://img.shields.io/cocoapods/v/QToasterSwift.svg)](https://cocoapods.org/pods/QToasterSwift)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/a-athaullah/QToasterSwift/master/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/a-athaullah/QToasterSwift.svg)](https://github.com/a-athaullah/QToasterSwift/stargazers)
[![iOS)](https://img.shields.io/badge/iOS-8.3%2B-blue.svg)](https://github.com/a-athaullah/QToasterSwift)
[![iOS)](https://img.shields.io/badge/xCode-7.3%2B-blue.svg)](https://github.com/a-athaullah/QToasterSwift)

Simple Swift in-app toast notification

## Features

- Show toast notification
- show toast notification with icon
- show toast notification with icon from URL
- add action on toaster onTouch
- Customable color, font, icon size, animate duration and delay duration

## Requirements

- iOS 8.3+ 
- Xcode 7.3+

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate QToasterSwift into your Xcode project using CocoaPods, specify it in your `Podfile`:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'QToasterSwift'
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage
### Show basic toast notification
Function to show default toast notification:

```
QToasterSwift.toast(target: UIViewController, text: String, title: String?, iconURL: String?, iconPlaceHolder: UIImage?, backgroundColor: UIColor?, textColor: UIColor?, onTouch: () -> Void)
```

all optional parameters can be removed

####Example 1 :
Show toaster with message (without title and other parameters):

```
QToasterSwift.toast(self, text: "Welcome to QToasterSwift")
```
###Example 2 :
Show toaster with message and title only:

```
QToasterSwift.toast(self, text: "Welcome to QToasterSwift", title: "Welcome")
```

###Example 3 :
Show toaster with icon UIImage and/or Image icon from URL:
#####UIImage icon:
```
let image = UIImage(named:"my-image")
QToasterSwift.toastWithIcon(self, text: "Welcome to QToasterSwift", icon: image, title: "Welcome")
```
#####Image from URL with placholder image:
```
let placeholderImage = UIImage(named: "placeholder-image")
let iconUrl = "https://my-icon-url/icon.jpg"
QToasterSwift.toast(self, 
					text: "Welcome to QToasterSwift", 
					title: "Welcome", 
					iconURL: iconUrl, 
					iconPlaceHolder: placeholderImage)
```

###Example 4 :
More complex basic toaster with onTouch action:
```
let placeholderImage = UIImage(named: "placeholder-image")
let iconUrl = "https://my-icon-url/icon.jpg"

QToasterSwift.toast(self, text: "Welcome to QToasterSwift sample usage code", 
					title: "Welcome", 
					iconURL: iconUrl, 
					iconPlaceHolder: placeholderImage,
					backgroundColor: UIColor.redColor(),
					textColor: UIColor.whiteColor(),
					onTouch: {
                		print("toaster touched")
            		}
)
```

##Customable Toaster