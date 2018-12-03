//
//  AppRegister.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/1.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 注册第三方
class AppRegister: NSObject {

    public class func registerApp(application: UIApplication?, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        do { //分享
            OpenShare.connectQQ(withAppId: kQQAppID)
            OpenShare.connectWeixin(withAppId: kWeChatAppID)
            OpenShare.connectWeibo(withAppKey: kSinaAppKey)
        }
        do { //3D Touch
            if let application = application {
                let items: [ShortcutItemTitleType] = [.hot, .note]
                var shortcutItems = [UIApplicationShortcutItem]()
                for item in items {
                    let icon = UIApplicationShortcutIcon(templateImageName: item.imageName)
                    let shortcutItem = UIApplicationShortcutItem(type: item.name, localizedTitle: item.name, localizedSubtitle: nil, icon: icon, userInfo: nil)
                    shortcutItems.append(shortcutItem)
                }
                application.shortcutItems = shortcutItems
            }
        }
    }
}

/// 3D Touch标题
enum ShortcutItemTitleType {
    /// 热门消息
    case hot
    /// 我的笔记
    case note
    
    var name: String {
        switch self {
        case .hot: return "热门消息"
        case .note: return "我的笔记"
        }
    }
    
    var imageName: String {
        switch self {
        case .hot: return "shortcut_message"
        case .note: return "shortcut_write"
        }
    }
}
