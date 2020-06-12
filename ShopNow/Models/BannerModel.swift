//
//  BannerModel.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/3/9.
//  Copyright © 2020 马瑜. All rights reserved.
//

import Foundation
import HandyJSON

class BannerModel: HandyJSON {
    var title: String?
    var desc: String?
    var image: String?
    var order: Int = 0
    var url: String?
    
    required init() {}
}

class HotModel: HandyJSON {
    var title: String?
    var desc: String?
    var image: String?
    var order: Int = 0
    var url: String?
    
    required init() {}
}
