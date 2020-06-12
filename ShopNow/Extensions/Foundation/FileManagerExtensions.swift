//
//  FileManagerExtensions.swift
//  ShopNow
//
//  Created by 马瑜 on 2019/4/10.
//  Copyright © 2019 马瑜. All rights reserved.
//

import UIKit

public extension FileManager {
    static func fileExistInMainBundle(fileName: String) -> Bool {
        return FileManager.default.fileExists(atPath: Bundle.main.bundlePath.appending("/\(fileName)"))
    }
}
