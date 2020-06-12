//
//  UIViewController.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/3/30.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit

extension UIViewController {
    class func fromStoryboard(
        name: String? = nil,
        identifier: String? = nil
    ) -> Self? {
        let selfName = String(describing: self)
        let storyboard = UIStoryboard(name: name ?? selfName,  bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier ?? selfName)
        return viewController as? Self
    }
    
    class func instantiateByMainStoryboard() -> Self? {
        let fullName = NSStringFromClass(self)
        let classname = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: classname) as? Self
    }
}
