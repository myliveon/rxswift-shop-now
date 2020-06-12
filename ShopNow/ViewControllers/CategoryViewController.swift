//
//  CategoryViewController.swift
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

class CategoryViewController: BaseViewController {
        
    
    private var tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain)
    fileprivate var didScroll: ((UIScrollView) -> ())?
    private var bag: DisposeBag = DisposeBag()

    private let CellId: String = "MusicListCellId"
//    lazy var dataSource = getDataSource()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分类"
//
//        tableView.backgroundColor = UIColor("171823")
//        tableView.showsVerticalScrollIndicator = false
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
//        tableView.estimatedRowHeight = 95
//        view.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        tableView.separatorStyle = .none
//
//        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never
//        } else {
//            automaticallyAdjustsScrollViewInsets = false
//        }
//
//
    }
//
//
//
//}
//
//extension CategoryViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 85
//    }
//}
//
//extension CategoryViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.dataSource.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath) as! MusicViewCell
//        let cellViewModel = viewModel.dataSource[indexPath.row]
//        cell.bind(viewModel: cellViewModel)
//        return cell
//    }
//}
//
//extension CategoryViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        didScroll?(scrollView)
//    }
//}
//
//
//extension CategoryViewController: ContainScrollView {
//    func scrollView() -> UIScrollView {
//        return tableView
//    }
//
//    func scrollViewDidScroll(callBack: @escaping (UIScrollView) -> ()) {
//        didScroll = callBack
//    }
}
