//
//  CoustomViewModel.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/25.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct CoustomViewModel {

    
    
    public var couponTap: BehaviorRelay<Void>
    
    public var couponTapEventDriver: Driver<Void> {
        return couponTap.asDriver().skip(1)
    }
    
    let disposeBag = DisposeBag()
    
    
}
