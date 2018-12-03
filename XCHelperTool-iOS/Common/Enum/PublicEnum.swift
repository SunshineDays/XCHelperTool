//
//  PublicEnum.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/8.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

// MARK: - 性别

/// 性别类型
enum UserGenderType: Int {
    /// 男
    case male = 1
    /// 女
    case female = 2
    /// 保密
    case none = 0
    
    var name: String {
        switch self {
        case .male: return "男"
        case .female: return "女"
        case .none: return "保密"
        }
    }
}


// MARK: - 银行卡

/// 银行卡类型
enum BankCardtype {
    /// 信用卡
    case credit
    /// 储蓄卡
    case debit
    
    var name: String {
        switch self {
        case .credit: return "信用卡"
        case .debit: return "储蓄卡"
        }
    }
    
    var id: Int {
        switch self {
        case .credit: return 1
        case .debit: return 2
        }
    }
}


// MARK: - 验证码

/// 验证码类型
enum UserAuthCodeType {
    /// 登录
    case login
    /// 注册
    case register
    /// 修改登录密码
    case editPassword
    /// 找回登录密码
    case findPassword
    /// 设置支付密码
    case buildPayPassword
    /// 修改支付密码
    case editPayPassword
    /// 绑定银行卡
    case bindBank
    /// 更换手机号
    case editPhone
    
    /// 验证码id
    var codeID: Int {
        switch self {
        case .login: return 0
        case .register: return 1
        case .editPassword: return 2
        case .findPassword: return 3
        case .buildPayPassword: return 4
        case .editPayPassword: return 5
        case .bindBank: return 6
        case .editPhone: return 7
        }
    }
    
    /// navigationItem.title
    var title: String {
        switch self {
        case .login: return "登录"
        case .register: return "设置登录密码"
        case .editPassword: return "重置登录密码"
        case .findPassword: return "找回登录密码"
        case .buildPayPassword: return "设置支付密码"
        case .editPayPassword: return "重置支付密码"
        case .bindBank: return "绑定银行卡"
        case .editPhone: return "更换手机号"
        }
    }
}


// MARK: - 按钮改变的几种状态

/// 按钮改变的几种状态
enum InputTextType {
    /// 空
    case none
    /// 默认
    case other
    /// 电话号码
    case phone
    /// 验证码
    case authCode
    /// 银行卡号
    case bankCard
    /// 身份证号码
    case idCard
    /// 密码
    case password
    /// 有效期
    case expiryData
    
    /// 文本最短长度
    var minCount: Int {
        switch self {
        case .none : return 0
        case .other: return 1
        case .phone: return 8
        case .authCode: return 6
        case .bankCard: return 10
        case .idCard: return 10
        case .password: return 6
        case .expiryData: return 4
        }
    }
    
    /// 文本最长长度
    var maxCount: Int {
        switch self {
        case .none : return 1000
        case .other: return 100
        case .phone: return 20
        case .authCode: return 6
        case .bankCard: return 30
        case .idCard: return 30
        case .password: return 25
        case .expiryData: return 4
        }
    }
}


