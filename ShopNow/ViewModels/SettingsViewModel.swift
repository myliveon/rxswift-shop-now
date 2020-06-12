//
//  SettingsViewModel.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/29.
//  Copyright © 2020 马瑜. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SettingsViewModel: ViewModel, ViewModelType {
    struct Input {
        let switchTheme: Observable<Bool>
        var logout: Observable<Void>?
    }
    struct Output {
        var logoutSuccess: Observable<Void>?
    }
    
    func transform(input: Input) -> Output {
        input.switchTheme
            .map { $0 ? ThemeType.dark : .light }
            .bind(to: appTheme.switcher)
            .disposed(by: disposeBag)
        
        var logoutSuccess: Observable<Void>?
        if let logout = input.logout {
        }
        
        return Output(
            logoutSuccess: logoutSuccess
        )
    }
}

