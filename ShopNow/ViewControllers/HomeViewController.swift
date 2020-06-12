//
//  HomeViewController.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/24.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import Moya
import HandyJSON
import MJRefresh

class HomeViewController: BaseViewController {
    
    typealias HomeSectionModel = SectionModel<String, Any>
    
    lazy var listView: HomeListView = {
        let listView = HomeListView()
        listView.register(BannerCollectionViewCell.self)
        listView.registerNib(HotCollectionViewCell.self)
        listView.registerNib(ProductCollectionViewCell.self)
        return listView
    }()
    
    let viewModel = HomeViewModel(style: .img)
    
    lazy var dataSource = getDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        
        viewModel.loading.asObservable().bind(to: listView.isLoading).disposed(by: disposeBag)
        viewModel.loading.asObservable().bind(to: showLoading).disposed(by: disposeBag)
        viewModel.error.asObservable().bind(to: showError).disposed(by: disposeBag)
        
        let input = HomeViewModel.Input(
            refresh: listView.refresh,
            loadMore: listView.loadMore
        )
        let output = viewModel.transform(input: input)
        
        Observable.combineLatest(output.banners, output.hots, output.products)
            .map { (tup) -> [HomeSectionModel] in
                return [
                    HomeSectionModel(model: "banner", items: [tup.0]),
                    HomeSectionModel(model: "hot", items: tup.1),
                    HomeSectionModel(model: "products", items: tup.2)
                ]
        }
        .asDriver(onErrorJustReturn: [])
        .drive(listView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
        
        // 处理点击事件
        selectModelAction()
        
        listView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func configViews() {
        view.addSubview(listView)
        listView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        let searchBar = SearchBar(style: .click)
        searchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 12, height: 36)
        searchBar.placeholder = "搜索"
        self.navigationItem.titleView = searchBar
        appTheme.rx
            .bind({ $0.backgroundColor }, to: searchBar.rx.backgroundColor)
            .bind({ $0.textColor }, to: searchBar.rx.tintColor)
    }
    
}

// MARK:点击事件
extension HomeViewController {
    private func selectModelAction() {
        // 点击goodscell
        listView.rx.modelSelected(ProductCellViewModel.self)
        .subscribeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] model in
            guard let `self` = self else { return }
            print("ProductCellViewModel")
        }).disposed(by: disposeBag)
        
        // 点击图片
        viewModel.imgTapEventDriver.drive(onNext: { [weak self] model in
            guard let `self` = self else { return }
            print("imgTapEventDriver = .\(String(describing: model.title))")
        }).disposed(by: disposeBag)
    }
    
    
}

// MARK:数据赋值
extension HomeViewController {
    private func getDataSource() -> RxCollectionViewSectionedReloadDataSource<HomeSectionModel> {
        return RxCollectionViewSectionedReloadDataSource<HomeSectionModel>(configureCell: { (ds, collectionView, indexPath, item) in
            let listView = collectionView as! HomeListView
            switch item {
            case is [BannerModel]:
                let cell = listView.dequeueReusableCell(BannerCollectionViewCell.self, for: indexPath)
                cell.bind(model: item as! [BannerModel])
                return cell
            case is HotViewModel:
                let cell = listView.dequeueReusableCell(HotCollectionViewCell.self, for: indexPath)
                cell.bind(viewModel: item as! HotViewModel)
                return cell
            case is ProductCellViewModel:
                let cell = listView.dequeueReusableCell(ProductCollectionViewCell.self, for: indexPath)
                cell.bind(to: item as! ProductCellViewModel)
                return cell
            default:
                fatalError()
            }
        })
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 24
        let itemWidth = (UIScreen.main.bounds.width-30)/2
        let hotItemWidth = (UIScreen.main.bounds.width-50)/4
        let item = dataSource[indexPath]
        switch item {
        case is [BannerModel]:
            return CGSize(width: width, height: 200)
        case is HotViewModel:
            return CGSize(width: hotItemWidth, height: hotItemWidth + 30)
        case is ProductCellViewModel:
            let cell = self.listView.templateCell(ProductCollectionViewCell.self, for: indexPath)
            cell.bind(to: item as! ProductCellViewModel)
            return CGSize(width: itemWidth, height: itemWidth + 50)
        default:
            fatalError()
        }
    }
}
