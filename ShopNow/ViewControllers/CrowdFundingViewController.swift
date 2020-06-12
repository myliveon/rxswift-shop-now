//
//  CrowdFundingViewController.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/28.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit

var segmentViewHeight: CGFloat { return 40 }

open class CustomHostScrollView: UICollectionView {
    
    public override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let view = otherGestureRecognizer.view else { return false }
        if view is UIScrollView {
            return true
        }
        return false
    }
}

class CrowdFundingViewController: BaseViewController {

    
    private var isHostScrollViewEnable = true
    private var isContainScrollViewEnable = false

    var childVCs: [ContainScrollView] = []
    private var collectionView: CustomHostScrollView!
    private var contentView: CollectionViewCellContentView!
    private var headerView: CrowdFundingHeaderView?
    private var navigationView: UIView!
    private var navigationViewHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.statusBarFrame.height + 34
        } else {
            return 54
        }
    }
    
    private var headerViewHeight: CGFloat {
        return 480.0 / 750.0 * view.width
    }
    
    private var stopScrollOffset: CGFloat {
        return headerViewHeight - navigationViewHeight - segmentViewHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor("1D1621")
        navigationBarHidden = true
        
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = CustomHostScrollView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        if #available(iOS 11.0, *) {
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        
        
        collectionView.register(CrowdFundingHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:CrowdFundingHeaderView.self.description())
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        navigationView = UIView()
        navigationView.backgroundColor = UIColor("171823")
        navigationView.isHidden = true
        view.addSubview(navigationView)
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        
        navigationView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: navigationViewHeight).isActive = true
        
        let titleLabel = UILabel(text: "众筹计划", font: .systemFont(ofSize: 18))
        titleLabel.textColor = UIColor.white
        navigationView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor, constant: 15).isActive = true
        
        contentView = CollectionViewCellContentView()
        contentView.hostScrollView = collectionView
        
        initSubViewController()
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        
    func initSubViewController() {
            
        let fundingListViewModel = CrowdFundingListViewModel(style: .funding)
        let fundingVC = FundingViewController(viewModel: fundingListViewModel)
        childVCs.append(fundingVC)
        
        let successListViewModel = CrowdFundingListViewModel(style: .success)
        let successVC = FundingViewController(viewModel: successListViewModel)
        childVCs.append(successVC)
          
        let failListViewModel = CrowdFundingListViewModel(style: .fail)
        let failVC = FundingViewController(viewModel: failListViewModel)
        childVCs.append(failVC)
        
        childVCs.forEach { (vc) in
            addChild(vc)
            vc.scrollViewDidScroll(callBack: { [weak self] (scrollview) in
                self?.containScrollViewDidScroll(scrollview)
            })
        }
    }
}

extension CrowdFundingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.width, height: headerViewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if #available(iOS 11.0, *) {
            return CGSize(width: view.width, height: view.height - navigationViewHeight - segmentViewHeight - view.safeAreaInsets.bottom)
        } else {
            return CGSize(width: view.width, height: view.height - navigationViewHeight - segmentViewHeight - 10)
        }
    }
}

extension CrowdFundingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)
        contentView.delegate = self
        cell.contentView.addSubview(contentView)
        contentView.frame = cell.contentView.bounds
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:CrowdFundingHeaderView.self.description(), for: indexPath) as? CrowdFundingHeaderView
        headerView?.segmentView.delegate = self
        return headerView!
    }
    
}
extension CrowdFundingViewController: CollectionViewCellContentViewDataSource {
    func collectionViewScroll(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        headerView?.segmentView.setTitle(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    
    func numberOfViewController() -> Int {
        return childVCs.count
    }
        
    func viewController(itemAt indexPath: IndexPath) -> UIViewController {
        return childVCs[indexPath.item]
    }
}

extension CrowdFundingViewController {
    func containScrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        
        // 向上滑动时
        if offsetY > 0 {
            if isContainScrollViewEnable {
                scrollView.showsVerticalScrollIndicator = true
                
                if collectionView.contentOffset.y == 0 {
                    self.isHostScrollViewEnable = true
                    self.isContainScrollViewEnable = false
                    
                    scrollView.contentOffset = .zero
                    scrollView.showsVerticalScrollIndicator = false
                }else {
                    self.collectionView.contentOffset = CGPoint(x: 0, y: stopScrollOffset)
                }
                
            } else {
                scrollView.contentOffset = CGPoint.zero
                scrollView.showsVerticalScrollIndicator = false
            }
        } else { //向下滑动时
            isContainScrollViewEnable = false
            isHostScrollViewEnable = true
            scrollView.contentOffset = CGPoint.zero
            scrollView.showsVerticalScrollIndicator = false
        }
    }
}

extension CrowdFundingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        // 判断是否可以继续向上滑动
        if offsetY >= stopScrollOffset {
            scrollView.contentOffset.y = stopScrollOffset
            if isHostScrollViewEnable {
                isHostScrollViewEnable = false
                isContainScrollViewEnable = true
            }
        } else {
            if isContainScrollViewEnable {
                scrollView.contentOffset.y = stopScrollOffset
            }
        }
        // 导航栏相关逻辑
        if scrollView.contentOffset.y < 0 {
            headerView?.backgroundImageAnimation(offset: scrollView.contentOffset.y)
            navigationView.isHidden = true
        } else {
            navigationView.isHidden = false
            navigationView.alpha = scrollView.contentOffset.y / stopScrollOffset
        }
    }
}
extension CrowdFundingViewController: CustomSegmentViewDelegate {
    func pageSegment(selectedIndex index: Int) {
        contentView.switchPage(index: index)
    }
}
