//
//  CrowdFundingCollectionViewCell.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/5/29.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import RxSwift

class CrowdFundingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rateLab: UILabel!
    @IBOutlet weak var moneyLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    
    let disposeBag = DisposeBag()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        configThemes()
    }
    
    
    private func configThemes() {
        backgroundColor = .clear
        appTheme.rx
            .bind({ $0.lightBackgroundColor }, to: rx.backgroundColor)
            .bind({ $0.textColor }, to: rateLab.rx.textColor)
            .bind({ $0.subTextColor }, to: moneyLab.rx.textColor, timeLab.rx.textColor)
            .disposed(by: disposeBag)
    }

}
