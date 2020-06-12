//
//  Theme.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/3/9.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import RxSwift
import RxTheme

protocol Theme {
    var primaryColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var lightBackgroundColor: UIColor { get }
    
    var textColor: UIColor { get }
    var subTextColor: UIColor { get }
}

struct LightTheme: Theme {
    let primaryColor = UIColor("52b6f4")!
    let backgroundColor = UIColor("f0f0f0")!
    let lightBackgroundColor = UIColor.white
    
    let textColor = UIColor.black
    let subTextColor = UIColor.gray
}

struct DarkTheme: Theme {
    let primaryColor = UIColor("0x52b6f4")!
    let backgroundColor = UIColor(red: 42, green: 42, blue: 42)!
    let lightBackgroundColor = UIColor(red: 60, green: 63, blue: 65)!
    
    let textColor = UIColor.white
    let subTextColor = UIColor.gray
}

enum ThemeType: ThemeProvider {
    case light, dark
    var associatedObject: Theme {
        switch self {
        case .light:
            return LightTheme()
        case .dark:
            return DarkTheme()
        }
    }
}

let appTheme = { () -> ThemeService<ThemeType> in
    var type = ThemeType.light
    if #available(iOS 13, *) {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            type = .dark
        }
    }
    return ThemeType.service(initial: type)
}()

/// APP font size
extension UIFont {
    class var largeTitle: UIFont {
        return UIFont.systemFont(ofSize: 20)
    }
    
    class var title: UIFont {
        return UIFont.systemFont(ofSize: 17)
    }
    class var subTitle: UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    class var small: UIFont {
        return UIFont.systemFont(ofSize: 13)
    }
}
