//
//  HomeListView.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/23.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import MJRefresh
import RxSwift
import RxCocoa

class HomeListView: UICollectionView {
    
    
    lazy var refresh: BehaviorSubject<Void> = {
        let subject = BehaviorSubject<Void>(value: ())
        mj_header = MJRefreshNormalHeader {
            subject.onNext(())
        }
        return subject
    }()
    
    lazy var loadMore: PublishSubject<Void> = {
        let subject = PublishSubject<Void>()
        mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            subject.onNext(())
        })
        return subject
    }()
    
    lazy var isLoading: PublishSubject<Bool> = {
        let isLoading = PublishSubject<Bool>()
        isLoading.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] loading in
            if !loading {
                self?.mj_header?.endRefreshing()
                self?.mj_footer?.endRefreshing()
            }
        }).disposed(by: disposeBag)
        return isLoading
    }()
    
    private let disposeBag = DisposeBag()
    private lazy var templateCells = [String: UICollectionViewCell]()
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        return layout
    }()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .clear
        
    }
    
    func templateCell<collectioncell: UICollectionViewCell>(_ type: collectioncell.Type, for indexPath: IndexPath) -> collectioncell {
        let identifier = "\(type)"
        if let cell = templateCells[identifier] {
            return cell as! collectioncell
        }
        let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! collectioncell
        templateCells[identifier] = cell
        return cell
    }
    
    func register<collectioncell: UICollectionViewCell>(_ type: collectioncell.Type) {
        register(type, forCellWithReuseIdentifier: "\(type)")
    }
    
    func register<collectionView: UICollectionReusableView>(_ type: collectionView.Type, elementKind: String) {
        register(type, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: "\(type)")
    }
    
    func registerNib<collectionCell: UICollectionViewCell>(_ type: collectionCell.Type) {
        register(UINib(nibName: "\(type)", bundle: nil), forCellWithReuseIdentifier: "\(type)")
    }
    
    func dequeueReusableCell<collectioncell: UICollectionViewCell>(_ type: collectioncell.Type, for indexPath: IndexPath) -> collectioncell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: "\(type)", for: indexPath) as? collectioncell else {
            fatalError("\(type): unregistered")
        }
        return cell
    }
    
    func dequeueReusableView<collectionView: UICollectionReusableView>(
        ofKind elementKind: String,
        withType type: collectionView.Type,
        for indexPath: IndexPath
    ) -> collectionView {
        guard let view = dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: "\(type)", for: indexPath) as? collectionView else {
            fatalError("\(type), kind: \(elementKind): unregistered")
        }
        return view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
