//
//  ProductCellViewModel.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/28.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct ProductCellViewModel {

    let title = BehaviorRelay<String?>(value: nil)
    let price = BehaviorRelay<String?>(value: nil)
    let image = BehaviorRelay<String?>(value: nil)
    let saleCount = BehaviorRelay<String?>(value: nil)
    
    let disposeBag = DisposeBag()
    
    let product: ProductModel
    
    init(product: ProductModel) {
        self.product = product
        title.accept(product.title)
    }
    
}

extension ProductCollectionViewCell {
    func bind(to viewModel:ProductCellViewModel) {
        let disposeBag = viewModel.disposeBag
        
        viewModel.title.asDriver().drive(titleLab.rx.text).disposed(by: disposeBag)
        viewModel.price.asDriver().drive(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            if let price = viewModel.product.price {
                self.priceLab.text = "$" + price
            }
        }).disposed(by: disposeBag)
        viewModel.saleCount.asDriver().drive(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            if let sale = viewModel.product.sold_count {
                self.saleLab.text = "销量:" + sale
            }
        }).disposed(by: disposeBag)
        
        viewModel.image.asDriver().drive(onNext: { [weak self] image in
            guard let `self` = self else { return }
            if let path = viewModel.product.image {
                self.imageView.kf.setImage(with: URL(string: path))
            }
        }).disposed(by: disposeBag)
        
    }
}
