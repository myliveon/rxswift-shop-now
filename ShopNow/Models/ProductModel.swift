//
//  ProductModel.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/5/28.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import HandyJSON

class ProductModel: HandyJSON {

    var title: String?
    var image: String?
    var sold_count: String?
    var price: String?
    
    
    required init() {
        
    }
}
