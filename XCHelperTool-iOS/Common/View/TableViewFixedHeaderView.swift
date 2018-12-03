//
//  TableViewFixedHeaderView.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/31.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 固定头部视图 (类似京东/天猫商品详情的头部)
class TableViewFixedHeaderView: UIView {
    
    private let tableHaderScrollView = UIScrollView()
    
    /// 可以在这里添加view
    public let contentView = UIView()
    
    /// 是否下拉头部固定
    public var isDropFixed: Bool = true
    
    /// 顶部相对tableView的速度(最小为1)
    public var relativeSpeed: CGFloat = 1.0
    
    /// contentOffset.y
    public var contentOffsetY: CGFloat = 0 {
        didSet {
            let y = contentOffsetY
            let speed = relativeSpeed > 1.0 ? relativeSpeed : 1.0
            if y > 0 {
                tableHaderScrollView.contentOffset = CGPoint(x: tableHaderScrollView.contentOffset.x, y: -(y / speed))
            } else {
                tableHaderScrollView.frame = CGRect(x: 0, y: isDropFixed ? y : 0, width: frame.width, height: frame.height)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        
        tableHaderScrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(tableHaderScrollView)
        
        contentView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        contentView.backgroundColor = UIColor.yellow
        tableHaderScrollView.addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
