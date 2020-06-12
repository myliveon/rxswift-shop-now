//
//  CrowdFundingListViewModel.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/29.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class CrowdFundingListViewModel: ViewModel, ViewModelType {

    enum CrowdStyle {
        case funding
        case success
        case fail
    }
    
    private var style:CrowdStyle
    
    struct Input {
        let refresh: Observable<Void>
        let loadMore: Observable<Void>
    }
    
    struct Output {
        let crowdFundings: Observable<[CrowdFundingCellViewModel]>
    }
    
    init(style: CrowdStyle) {
        self.style = style
    }
    private var page: Int = 1
    
    private let crowdFundings = BehaviorRelay<[CrowdFundingModel]>(value: [])
    
    
    func transform(input: Input) -> Output {
        input.refresh
            .flatMapLatest({ [weak self] () -> Observable<[CrowdFundingModel]> in
                guard let `self` = self else { return Observable.just([]) }
                self.page = 1
                return self.fetchCrowdFundings()
            })
            .subscribe(onNext: {[weak self] models in
                guard let `self` = self else { return }
                self.crowdFundings.accept(models)
            })
            .disposed(by: disposeBag)
        
        input.loadMore
            .flatMapLatest({ [weak self] () -> Observable<[CrowdFundingModel]> in
                guard let `self` = self else { return Observable.just([]) }
                self.page += 1
                return self.fetchCrowdFundings(page: self.page)
            })
            .subscribe(onNext: { [weak self] models in
                guard let `self` = self else { return }
                self.crowdFundings.accept(self.crowdFundings.value + models)
            })
            .disposed(by: disposeBag)
        
        let crowdFundingViewModels = self.crowdFundings.map { models in
                    return models.map { model -> CrowdFundingCellViewModel in
                        let viewModel = CrowdFundingCellViewModel(crowdFunding: model)
                        return viewModel
                    }
                }
        return Output(
            crowdFundings: crowdFundingViewModels.asObservable()
        )
    }
    
    func fetchCrowdFundings(page: Int = 0) -> Observable<[CrowdFundingModel]> {
        var type = "fail"
        switch style {
        case .funding:
            type = "funding"
        case .success:
            type = "success"
        case .fail:
            type = "fail"
        }
        
        return API.provider
        .rx
        .request(.crowdFunding(page: page, type: type))
        .mapModelList(CrowdFundingModel.self, path: "data.list")
        .catchErrorJustReturn([])
    }
    
    
}
