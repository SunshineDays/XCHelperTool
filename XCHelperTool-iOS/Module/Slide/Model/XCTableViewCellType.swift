//
//  XCTableViewCellType.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/10.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// TabelViewCell类型
enum TableViewCellType {
    
    case slide1
    case slide2
    
    var cellName: String {
        switch self {
        case .slide1: return "XCSlide1Cell"
        case .slide2: return "XCSlide2Cell"
        }
    }
    
    var cellRowHeight: CGFloat {
        switch self {
        case .slide1: return 100
        case .slide2: return 150
        }
    }
    
    var headerCellName: String {
        switch self {
        case .slide1: return "XCSlide1HeaderCell"
        case .slide2: return "XCSlide1HeaderCell"
        }
    }
    
    var headerCellRowHeight: CGFloat {
        switch self {
        case .slide1: return 50
        case .slide2: return 50
        }
    }
    
    var footerCellName: String {
        return "XCSlideFooterCell"
    }
}
