//
//  Base.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/3/17.
//  Copyright © 2020 马瑜. All rights reserved.
//

import Foundation
import Moya

extension TargetType {
    var baseURL: URL {
        return URL(string: "https://shop.sts188.cn/")!
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}

let defaultPlugins = { () -> [PluginType] in
    #if DEBUG
    return [NetworkLogger()]
    #else
    return []
    #endif
}()
