//
//  HotViewModel.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/25.
//  Copyright © 2020 马瑜. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HotViewModel: NSObject {
    
    var hotModel: HotModel

    var imgTap: BehaviorRelay<HotModel>
    
//    let collectTap = PublishRelay<Void>()
    
    let disposeBag = DisposeBag()
    
    init(hotModel: HotModel, imgTap: BehaviorRelay<HotModel>) {
        self.hotModel = hotModel
        self.imgTap = imgTap
    }
    
    
}
