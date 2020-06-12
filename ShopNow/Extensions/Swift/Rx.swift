//
//  Rx.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/3/14.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


extension Reactive where Base: UINavigationBar {
    var barBackgroundColor: Binder<UIColor?> {
        return Binder<UIColor?>(self.base) { (bar, color) in
            let bgColor = color ?? .white
            let bgImage = bgColor.mapImage
            bar.setBackgroundImage(bgImage, for: .default)
        }
    }
    var titleColor: Binder<UIColor?> {
        return Binder<UIColor?>(self.base) { (bar, color) in
            bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color ?? .black]
        }
    }
}

extension ObservableType {
    func catchErrorJustComplete() -> Observable<E> {
        return catchError { (_) -> Observable<E> in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    public func filterNil<E>() -> Observable<E>  {
        return self.filter { $0 != nil }.map { $0 as! E }
    }
}
