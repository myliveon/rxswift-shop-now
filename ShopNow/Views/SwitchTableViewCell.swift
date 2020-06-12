//
//  SwitchTableViewCell.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/29.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    var `switch`: UISwitch = {
        let sw = UISwitch()
        return sw
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryView = self.switch
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
