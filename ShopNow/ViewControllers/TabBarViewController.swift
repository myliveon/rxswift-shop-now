//
//  RootViewController.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/3/9.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxTheme

extension Reactive where Base: UITabBar {
    var barBackgroundColor: Binder<UIColor?> {
        return Binder<UIColor?>(self.base) { (bar, color) in
            let bgColor = color ?? .white
            let bgImage = bgColor.mapImage
            bar.backgroundImage = bgImage
        }
    }
}

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewControllersConfig()
    }
    
}

extension TabBarViewController {
    private struct Item {
        let title: String
        let icon: Iconfont
        let vc: UIViewController
    }
    
    private func initViewControllersConfig() {
            
        let items = [
            Item(title: "首页", icon: Iconfont.home, vc: HomeViewController()),
            Item(title: "众筹", icon: Iconfont.tree, vc: CrowdFundingViewController()),
            Item(title: "我的", icon: Iconfont.user, vc: MineViewController()),
        ]
        
        viewControllers = items.map { item in
            item.vc.tabBarItem.title = item.title
            item.vc.tabBarItem.image = item.icon.image(size: 24)
            let nav = NavigationViewController(rootViewController: item.vc)
            return nav
        }
        
        appTheme.rx.bind({ $0.primaryColor }, to: tabBar.rx.tintColor)
        appTheme.rx.bind({ $0.lightBackgroundColor }, to: tabBar.rx.barTintColor)
    }
    
    class func swichTo() {
        let window = UIApplication.shared.delegate?.window
        window??.rootViewController = TabBarViewController()
    }
}

extension TabBarViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let traitCollection = previousTraitCollection else { return }
        
        if #available(iOS 12.0, *) {
            /// appTheme 自动跟随系统
            let isDark = traitCollection.userInterfaceStyle == .dark
            let themeType: ThemeType = isDark ? .light : .dark
            if themeType != appTheme.type {
                appTheme.switch(themeType)
            }
        }
        
    }
}
