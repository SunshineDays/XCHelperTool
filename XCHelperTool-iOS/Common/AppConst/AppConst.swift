//
//  AppConst.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/5/31.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

// MARK: - UI相关常量

/// 屏宽
var kScreenWidth: CGFloat = UIScreen.main.bounds.size.width

/// 屏高
var kScreenHeight: CGFloat = UIScreen.main.bounds.size.height

///  状态栏高度
let kStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height

/// 导航栏高度(加上状态栏)
var kNavigationHeight: CGFloat = kStatusBarHeight + 44

/// 是否是iPhoneX
let kIsIphoneX: Bool = kStatusBarHeight == 44

/// tabBar高度
let kTabBarHeight: CGFloat = kIsIphoneX ? 83 : 49

/// tabBar距离底部的距离
let kBottomMargin: CGFloat = kIsIphoneX ? 34 : 0

/// UITableView heightForHeaderInSection
let kHeaderInSectionHeight: CGFloat = 20

/// UITableView heightForFooterInSection
let kFooterInSectionHeight: CGFloat = 0.01

/// 重新获取验证码间隔时间
let kAuthCodeTimeInterval = 60


// MARK: - APP相关

/// api baseURL
let kBbaseURL = "https://ipa.sunshine.com/"          

/// AppStore下载地址
let kAppStoreURL = "https://itunes.apple.com/cn/app/id1147456885"

/// 客服电话
let kAppServiceTel = "17621746288"

/// 客服QQ
let kAppServiceQQ = "1036739617"


// MARK: - 第三方

/// 微信 AppID
let kWeChatAppID = "46928347"

/// QQ APPID
let kQQAppID = "1441144"

/// 新浪微博 AppKey
let kSinaAppKey = ""

/// 高德地图 ApiKey
let kAMapApiKey = "1231231"

/// 极光推送
let kJPushAppKey = "23421414141"





