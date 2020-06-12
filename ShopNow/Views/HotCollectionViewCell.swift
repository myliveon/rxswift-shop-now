//
//  HotCollectionViewCell.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/24.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class HotCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titelLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}

extension HotCollectionViewCell {
    func bind(viewModel: HotViewModel) {
        if let path = viewModel.hotModel.image {
            imageView.kf.setImage(with: URL(string: path))
        }
        titelLab.text = viewModel.hotModel.title
        titelLab.font = UIFont.small
        let disposeBag = viewModel.disposeBag
        let tapGesture = UITapGestureRecognizer()
        imageView.addGestureRecognizer(tapGesture)
        tapGesture.rx.event.subscribe(onNext: { _ in
            viewModel.imgTap.accept((viewModel.hotModel))
        }).disposed(by: disposeBag)
    }
    
    public func setEvents(viewModel: HotViewModel) {
        
    }
    
}
