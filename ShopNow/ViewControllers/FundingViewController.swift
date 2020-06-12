//
//  FundingViewController.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/29.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class FundingViewController: BaseViewController {

    typealias FundingSectionModel = SectionModel<String, Any>
    
    lazy var listView: HomeListView = {
        let listView = HomeListView()
        listView.registerNib(CrowdFundingCollectionViewCell.self)
        return listView
    }()
    
    private let LINE_SPACE: CGFloat = 2
    private let ITEM_SPACE: CGFloat = 1
    
    private var itemWidth: CGFloat {
        return view.width / 3 - ITEM_SPACE * 2
    }
    
    private var itemHeight: CGFloat {
        return itemWidth * (330.0 / 248.0)
    }
    
    private let VideoListCellId = "VideoListCellId"
    private var didScroll:((UIScrollView) -> ())?
    private var collectionView: UICollectionView!
    
    public private(set) var viewModel: CrowdFundingListViewModel
    
//    let viewModel = CrowdFundingListViewModel(style: .funding)
    
    lazy var dataSource = getDataSource()
    
    init(viewModel: CrowdFundingListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarHidden = true
        
        view.addSubview(listView)
        listView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        
        viewModel.loading.asObservable().bind(to: listView.isLoading).disposed(by: disposeBag)
        viewModel.loading.asObservable().bind(to: showLoading).disposed(by: disposeBag)
        viewModel.error.asObservable().bind(to: showError).disposed(by: disposeBag)
        
        let input = CrowdFundingListViewModel.Input(
            refresh: listView.refresh,
            loadMore: listView.loadMore
        )
        let output = viewModel.transform(input: input)
        
        output.crowdFundings
        .map { [FundingSectionModel(model: "", items: $0)] }
        .asDriver(onErrorJustReturn: [])
        .drive(listView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
        
        listView.rx.setDelegate(self).disposed(by: disposeBag)
        
        if #available(iOS 11.0, *) {
            listView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        
    }
    
    
}

extension FundingViewController {
    private func getDataSource() -> RxCollectionViewSectionedReloadDataSource<FundingSectionModel> {
        return RxCollectionViewSectionedReloadDataSource<FundingSectionModel>(configureCell: { (ds, collectionView, indexPath, item) in
            let listView = collectionView as! HomeListView
            let cell = listView.dequeueReusableCell(CrowdFundingCollectionViewCell.self, for: indexPath)
            cell.bind(to: item as! CrowdFundingCellViewModel)
            return cell
        })
    }
}

extension FundingViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width - 24
        let itemWidth = (UIScreen.main.bounds.width-30)/2
//        let hotItemWidth = (UIScreen.main.bounds.width-50)/4
//        let item = dataSource[indexPath]
        return CGSize(width: itemWidth, height: itemWidth + 50)
    }
}


extension FundingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scrollView)
    }
}

extension FundingViewController: ContainScrollView {
    func scrollView() -> UIScrollView {
        return collectionView
    }
    
    func scrollViewDidScroll(callBack: @escaping (UIScrollView) -> ()) {
        didScroll = callBack
    }
}
