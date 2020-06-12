//
//  AppState.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/3.
//  Copyright © 2020 马瑜. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AppState {
    static let share = AppState()
    
    let loginUser = BehaviorRelay<UserModel>(value: UserModel())
}

extension AppState {
    func setup() {
        DispatchQueue.main.async {
            if let user = UserModel.fromLoacl() {
                self.loginUser.accept(user)
            }
        }
    }
}
