//
//  XCNotification.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/8.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 自定义通知
enum UserNotification: String {
    
    /// 修改地区成功
    case editAreaSuccess
    /// 需要登录
    case shouldLogin
    
    var notification: Notification.Name {
        return Notification.Name(rawValue: rawValue)
    }
}
