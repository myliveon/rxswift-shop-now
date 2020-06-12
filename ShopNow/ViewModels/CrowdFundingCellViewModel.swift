//
//  CrowdFundingCellViewModel.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/29.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct CrowdFundingCellViewModel {
    let image = BehaviorRelay<String?>(value: nil)
    let rate = BehaviorRelay<Int?>(value: nil)
    let money = BehaviorRelay<String?>(value: nil)
    let time = BehaviorRelay<String?>(value: nil)
    
    let disposeBag = DisposeBag()
    
    let crowdFunding: CrowdFundingModel
    
    init(crowdFunding: CrowdFundingModel) {
        self.crowdFunding = crowdFunding
        
    }
    
}

extension CrowdFundingCollectionViewCell {
    
    func bind(to viewModel:CrowdFundingCellViewModel) {
        let disposeBag = viewModel.disposeBag
        
        viewModel.rate.asDriver().drive(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            if let title = viewModel.crowdFunding.title {
                self.rateLab.text = (title)
            }
        }).disposed(by: disposeBag)
        
        viewModel.money.asDriver().drive(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            if let amount = viewModel.crowdFunding.total_amount {
                self.moneyLab.text = "已筹:$" + (amount)
            }
        }).disposed(by: disposeBag)
        
        viewModel.time.asDriver().drive(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            if let end = viewModel.crowdFunding.end_at {
                let time = end.prefix(10)
                self.timeLab.text = "结束:" + (time)
            }
        }).disposed(by: disposeBag)
        
        viewModel.image.asDriver().drive(onNext: { [weak self] image in
            guard let `self` = self else { return }
            if let path = viewModel.crowdFunding.image {
                self.imageView.kf.setImage(with: URL(string: path))
            }
        }).disposed(by: disposeBag)
        
    }
}
