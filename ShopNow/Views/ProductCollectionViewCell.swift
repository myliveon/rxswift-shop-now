//
//  ProductCollectionViewCell.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/28.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import RxSwift

class ProductCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var priceLab: UILabel!
    @IBOutlet weak var saleLab: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configThemes()
        
    }
    
    
    
    private func configThemes() {
        titleLab.textColor = .orange
        backgroundColor = .clear
        appTheme.rx
            .bind({ $0.lightBackgroundColor }, to: rx.backgroundColor)
            .bind({ $0.textColor }, to: titleLab.rx.textColor)
            .bind({ $0.subTextColor }, to: priceLab.rx.textColor, saleLab.rx.textColor)
            .disposed(by: disposeBag)
    }
    
    

}
