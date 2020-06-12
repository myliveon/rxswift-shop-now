//
//  HomeViewModel.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/3/9.
//  Copyright © 2020 马瑜. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class HomeViewModel: ViewModel, ViewModelType {
    
    enum ViewStyle {
        case img
        case goods
    }
    
    struct Input {
        let refresh: Observable<Void>
        let loadMore: Observable<Void>
//        let hotSelected: Driver<HotViewModel>
    }
    
    struct Output {
        let banners: Observable<[BannerModel]>
        let products: Observable<[ProductCellViewModel]>
        let hots: Observable<[HotViewModel]>
//        let hotSelectedOut: Driver<HotModel>
    }
    
    private var style: ViewStyle
    // 图片点击事件
    private var imgTap: BehaviorRelay<HotModel> = BehaviorRelay(value: (HotModel()))
    public var imgTapEventDriver: Driver<HotModel> {
        return imgTap.asDriver().skip(1)
    }
    
    private var page = 1
    
    private let products = BehaviorRelay<[ProductModel]>(value: [])
    private let banners = BehaviorRelay<[BannerModel]>(value: [])
    private let hots = BehaviorRelay<[HotModel]>(value: [])
    
    init(style: ViewStyle) {
        self.style = style
    }
    
    func transform(input: Input) -> Output {
        input.refresh
            .flatMapLatest { [weak self] () -> Observable<([BannerModel], [HotModel], [ProductModel])> in
                guard let `self` = self else {
                    return Observable.just(([], [], []))
                }
                self.page = 1
                return Observable
                    .zip(self.fetchBanners(), self.fetchHots(), self.fetchProducts())
                    .trackError(self.error)
                    .trackActivity(self.loading)
        }
        .subscribe(onNext: { [weak self] (banners, hots, products) in
            guard let `self` = self else { return }
            self.banners.accept(banners)
            self.hots.accept(hots)
            self.products.accept(products)
        }).disposed(by: disposeBag)
        
        input.loadMore
            .flatMapLatest { [weak self] () -> Observable<[ProductModel]> in
                guard let `self` = self else { return Observable.just([]) }
                self.page += 1
                return self.fetchProducts(page: self.page)
                    .trackError(self.error)
                    .trackActivity(self.loading)
        }
        .subscribe(onNext: { [weak self] products in
            guard let `self` = self else { return }
            self.products.accept(self.products.value + products)
        }).disposed(by: disposeBag)
        
        let productViewModels = self.products.map { models in
            return models.map { model -> ProductCellViewModel in
                let viewModel = ProductCellViewModel(product: model)
//                viewModel.collectTap.flatMapLatest { [weak self] _ -> Observable<Void> in
//                    guard let `self` = self else { return .empty() }
//                    return UserAPI.provider
//                        .rx
//                        .request(.collectArticle(model.id))
//                        .validateSuccess()
//                        .trackActivity(self.loading)
//                        .trackError(self.error)
//                        .catchErrorJustComplete()
//                }
//                .subscribe(onNext: {
//                    model.collect = true
//                }).disposed(by: viewModel.disposeBag)
                return viewModel
            }
        }
        
        let hotViewModels = self.hots.map { models in
            return models.map { model -> HotViewModel in
                let viewModel = HotViewModel(hotModel: model, imgTap: self.imgTap)
                return viewModel
            }
        }
        
//        let selected = input.hotSelected
//        .map { $0.hotModel }
//        .filter { $0.id != nil && $0.link != nil }
        
        return Output(
            banners: banners.asObservable(),
            products: productViewModels.asObservable(),
            hots: hotViewModels.asObservable()
//            hotSelectedOut:selected
        )
    }
    
    func fetchBanners() -> Observable<[BannerModel]> {
        return API.provider
            .rx
            .request(.banner)
            .mapModelList(BannerModel.self, path: "data.list")
            .catchErrorJustReturn([])
    }
    
    func fetchHots() -> Observable<[HotModel]> {
        return API.provider
            .rx
            .request(.identity)
            .mapModelList(HotModel.self, path: "data.list")
            .catchErrorJustReturn([])
    }
    
    func fetchProducts(page: Int = 1) -> Observable<[ProductModel]> {
        print("page = \(page)")
        return API.provider
            .rx
            .request(.product(page:page))
            .mapModelList(ProductModel.self, path: "data.list")
            .catchErrorJustReturn([])
    }
}
