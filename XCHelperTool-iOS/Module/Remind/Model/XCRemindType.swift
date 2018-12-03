//
//  XCRemindRepeatType.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/1.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 提醒时间重复规则
enum XCRemindRepeatType: Int {
    
    case none = 0

    case everyDay = 1
    
    case everyWeek = 7
    
    case everyMonth = 30
    
    case everyYear = 365
    
    var title: String {
        switch self {
        case .none: return "永不"
        case .everyDay: return "每天"
        case .everyWeek: return "每周"
        case .everyMonth: return "每月"
        case .everyYear: return "每年"
        }
    }
    
}

/// 提醒事件类型
enum XCRemindMarkType: Int {
    
    case none = 0
    
    case birthday = 1
    
    case anniversary = 2
    
    case holiday = 3
    
    case other = 6
    
    var title: String {
        switch self {
        case .none: return "默认"
        case .birthday: return "生日"
        case .anniversary: return "纪念日"
        case .holiday: return"节假日"
        case .other: return "其它"
        }
    }
}
