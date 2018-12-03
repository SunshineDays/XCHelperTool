//
//  EmptyRequestType.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/31.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 空数据类型
enum EmptyRequestType {
    /// 网络错误
    case error
    /// 没有数据
    case noData
    
    var image: UIImage {
        switch self {
        case .error: return UIColor.clear.convertToImage()
        case .noData: return UIColor.clear.convertToImage()
        }
    }
    
    var title: NSAttributedString {
        switch self {
        case .error:
            return PublicTool.attributedString(texts: ["加载失败\n\n", "点击重试"],
                                               fonts: [UIFont.systemFont(ofSize: 23), UIFont.systemFont(ofSize: 15)],
                                              colors: [UIColor.lightGray, UIColor(hex: 0x3B83F7)])
        case .noData:
            return PublicTool.attributedString(texts: ["暂无数据"],
                                               fonts: [UIFont.systemFont(ofSize: 20)],
                                              colors: [UIColor.lightGray])
        }
    }
}
