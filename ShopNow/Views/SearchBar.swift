//
//  SearchBar.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/3/13.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit

class SearchBar: UIView {
    
    enum Style {
        case click, input
    }
    
    var placeholder: String? {
        willSet {
            placeholderLabel.text = newValue
            textField.placeholder = newValue
        }
    }
    
    override var tintColor: UIColor! {
        willSet {
            iconView.image = Iconfont.search.image(size: 18, color: newValue)
            placeholderLabel.textColor = newValue
            textField.tintColor = newValue
            textField.textColor = newValue
        }
    }
    
    var searchHandler: ((String) -> Void)?
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: 36)
    }
    
    private(set) var style: Style
    private(set) lazy var textField: UITextField = {
        let tf = UITextField()
        tf.returnKeyType = .search
        return tf
    }()
    
    private lazy var contentView = UIView()
    private lazy var iconView = UIImageView()
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.title
        return label
    }()
    
    init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        addSubview(contentView)
//        configLayout(with: style)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = self.bounds
    }
    
    private func configLayout(with style: Style) {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
