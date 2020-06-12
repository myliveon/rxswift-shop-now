//
//  ProductListViewModel.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/28.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ProductListRepos {
    func fetchProducts(by id: String, at page: Int) -> Observable<[ProductModel]>
}

class ProductListViewModel: ViewModel, ViewModelType {
    struct Input {
        let selectedTab: PublishSubject<Int>
        let refresh: Observable<Void>
        let loadMore: Observable<Void>
    }
    
    struct Output {
        let products: Driver<[ProductCellViewModel]>
    }
    
    let repos: ProductListRepos
    private var page: Int = 0
    
    init(repos: ProductListRepos) {
        self.repos = repos
    }
    
    func transform(input: Input) -> Output {
        let products: BehaviorRelay<[ProductCellViewModel]> = BehaviorRelay(value: [])
        
        Observable
            .combineLatest(input.refresh, input.selectedTab)
            .flatMapLatest({ [weak self] (_, index) -> Observable<[ProductCellViewModel]> in
                guard let `self` = self else { return Observable.just([]) }
                self.page = 0
                return self.fetchProducts(index: index)
            })
            .subscribe(onNext: { models in
                products.accept(models)
            })
            .disposed(by: disposeBag)
        
        Observable
            .combineLatest(input.loadMore, input.selectedTab)
            .flatMapLatest({ [weak self] (_, index) -> Observable<[ProductCellViewModel]> in
                guard let `self` = self else { return Observable.just([]) }
                self.page += 1
                return self.fetchProducts(index: index, page: self.page)
            })
            .subscribe(onNext: { models in
                products.accept(products.value + models)
            })
            .disposed(by: disposeBag)
        
        return Output(
            products: products.asDriver()
        )
    }
    
    func fetchProducts(index: Int, page: Int = 0) -> Observable<[ProductCellViewModel]> {
        return repos.fetchProducts(by: String(index), at: page)
        .map { $0.map { ProductCellViewModel(product: $0) } }
        .trackErrorJustReturn(error, value: [])
        .trackActivity(loading)
    }
}
