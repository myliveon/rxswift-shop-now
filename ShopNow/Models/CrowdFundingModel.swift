//
//  CrowdFundingModel.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/29.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import HandyJSON

class CrowdFundingModel: HandyJSON {

    var title: String?
    var image: String?
    var user_count: String?
    var total_amount: String?
    var end_at: String?
    var target_amount: String?
    
    required init() {
        
    }
}
