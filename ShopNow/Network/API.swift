//
//  Api.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/3/9.
//  Copyright © 2020 马瑜. All rights reserved.
//

import Foundation
import Moya

enum API {
    case banner
    case identity
    case product(page: Int)
    case crowdFunding(page: Int, type: String)
}

extension API: TargetType {
    var baseURL: URL {
            return URL(string: "https://shop.sts188.cn")!
        }
    
    
    var path: String {
        switch self {
        case .banner:
            return "/banners"
        case .identity:
            return "/identity"
        case .product:
            return "/products"
        case .crowdFunding:
            return "/crowdfunding"
        }
    }
    
    var task: Task {
        switch self {
        case .banner, .identity:
            return .requestPlain
        case .product(page: let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        case .crowdFunding(page: let page, type: let type):
            return .requestParameters(parameters: ["page": page, "type": type], encoding: URLEncoding.default)
        }
    }
    
}

extension API {
    static let provider = MoyaProvider<API>(plugins: defaultPlugins)
}
