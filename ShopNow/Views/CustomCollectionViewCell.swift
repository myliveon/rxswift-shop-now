//
//  CustomCollectionViewCell.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/25.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var couponImg: UIImageView! // 优惠券
    @IBOutlet weak var seckillImg: UIImageView! // 秒杀
    @IBOutlet weak var groupImg: UIImageView! // 团购
    @IBOutlet weak var collectImg: UIImageView! // 收藏
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func setEvents(viewModel: CoustomViewModel) {
        let disposeBag = viewModel.disposeBag
        let couponTapGesture = UITapGestureRecognizer()
        couponImg.addGestureRecognizer(couponTapGesture)
        couponTapGesture.rx.event.subscribe(onNext: { _ in
            viewModel.couponTap.accept(())
        }).disposed(by: disposeBag)
    }
    

}
