//
//  AppDelegate.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/23.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabbarController: TabBarViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.backgroundColor = UIColor.white
        self.tabbarController = TabBarViewController()
        self.window!.rootViewController = self.tabbarController
        self.window!.makeKeyAndVisible()
        AppState.share.setup()
        return true
    }


}

