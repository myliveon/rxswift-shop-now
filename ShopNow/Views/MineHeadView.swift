//
//  MineHeadView.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/5/29.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import SnapKit

class MineHeadView: UIView {

    var headImgView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 35
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(headImgView)
        headImgView.snp.makeConstraints { (make) in
            make.height.width.equalTo(80)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        headImgView.image = UIImage(named: "usericon")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
