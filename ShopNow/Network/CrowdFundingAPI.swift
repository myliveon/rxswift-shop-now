//
//  CrowdFundingAPI.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/29.
//  Copyright © 2020 马瑜. All rights reserved.
//

import Foundation
import Moya

enum CrowdFundingAPI {
    case banner
    case identity
    case product(page: Int)
}

extension CrowdFundingAPI: TargetType {

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
        }
    }
    
    var task: Task {
        switch self {
        case .banner, .identity:
            return .requestPlain
        case .product(page: let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        }
    }
    
}

extension CrowdFundingAPI {
    static let provider = MoyaProvider<API>(plugins: defaultPlugins)
}
