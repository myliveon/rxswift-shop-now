//
//  CrowdFundingHeaderView.swift
//  ShopNow
//
//  Created by 马瑜 on 2020/4/28.
//  Copyright © 2020 马瑜. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class CrowdFundingHeaderView: UICollectionReusableView {
        
    private var headerImage: UIImageView!
    private var bgContainerView: UIView!
    private var userDesc: UILabel!
    public var segmentView: CustomSegmentView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override var reuseIdentifier: String? {
        return CrowdFundingHeaderView.self.description()
    }
}

// MARK: - UI 相关方法
extension CrowdFundingHeaderView {
    fileprivate func setUpUI() {
        addBackgroundImage()
        addBgContainerView()
        addUserDesc()
        addSegmentView()
    }
    
    private func addBackgroundImage() {
        headerImage = UIImageView()
        let url = "https://zbbs.jd.com/data/attachment/block/68/6825c837ea9e4d75c1aa0dbd5a1de0b8.jpg"
        headerImage.kf.setImage(with: URL(string: url))
        headerImage.contentMode = .scaleAspectFill
        addSubview(headerImage)   
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        
        headerImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        headerImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        headerImage.heightAnchor.constraint(equalTo: headerImage.widthAnchor, multiplier: 280.0 / 750.0).isActive = true
        
    }
    
    private func addBgContainerView() {
        bgContainerView = UIView()
        bgContainerView.backgroundColor = UIColor("171823")
        addSubview(bgContainerView)
        bgContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        bgContainerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bgContainerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bgContainerView.topAnchor.constraint(equalTo: headerImage.bottomAnchor).isActive = true
        bgContainerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func addUserDesc() {
        let textAttr = NSMutableAttributedString(string: "立刻发起众筹梦想，将你的独特创意分享给更多的人\n您好，欢迎来到众筹社区！\n产品众筹-众测社区-众筹社区-发起众筹-扶贫大赛")
        textAttr.addAttribute(.foregroundColor, value: UIColor(white: 1, alpha: 1), range: NSRange(location: 0, length: textAttr.length))
        textAttr.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 0, length: textAttr.length))
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        style.alignment = .natural
        textAttr.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: textAttr.length))
        
        userDesc = UILabel()
        userDesc.attributedText = textAttr
        userDesc.numberOfLines = 0
        bgContainerView.addSubview(userDesc)
        userDesc.translatesAutoresizingMaskIntoConstraints = false
        userDesc.leftAnchor.constraint(equalTo: bgContainerView.leftAnchor).isActive = true
        userDesc.topAnchor.constraint(equalTo: bgContainerView.topAnchor, constant: 10).isActive = true
    }
    
    private func addSegmentView() {
        segmentView = CustomSegmentView()
        bgContainerView.addSubview(segmentView)
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        
        segmentView.leftAnchor.constraint(equalTo: bgContainerView.leftAnchor).isActive = true
        segmentView.rightAnchor.constraint(equalTo: bgContainerView.rightAnchor, constant: -16).isActive = true
        segmentView.bottomAnchor.constraint(equalTo: bgContainerView.bottomAnchor).isActive = true
        segmentView.heightAnchor.constraint(equalToConstant: segmentViewHeight).isActive = true
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(white: 1, alpha: 0.2)
        bgContainerView.addSubview(bottomLine)
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        bottomLine.leftAnchor.constraint(equalTo: bgContainerView.leftAnchor).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: bgContainerView.bottomAnchor).isActive = true
        bottomLine.rightAnchor.constraint(equalTo: bgContainerView.rightAnchor).isActive =  true
        bottomLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    func backgroundImageAnimation(offset: CGFloat) {
        let rotio = CGFloat(fabsf(Float(offset))) / width
        let height = (rotio * width) / 2
        headerImage.transform = CGAffineTransform(scaleX: rotio + 1, y: rotio + 1).concatenating(CGAffineTransform(translationX: 0, y: -height))
        
    }
}

