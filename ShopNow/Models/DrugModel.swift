//
//  DrugModel.swift
//  RxSwiftMVVMDemo
//
//  Created by wujuan on 2019/7/26.
//  Copyright © 2019 guahao. All rights reserved.
//

import Foundation

struct Drugs: Codable {
    let items:[DrugModel]
    private enum Codingkeys: String, CodingKey {
        case items
    }
    
}

struct DrugModel: Codable {
    let defaultSpecialUsage: String
    var drugCount:Int
    let drugId: String
    let drugName: String
    let maxPrice: Double
    let minPrice: Double
    let unit: String
    
    
}
