//
//  URLParameter.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/14.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// URL
enum AppPathURLType: String {
    case userLogin = "user/login"
    case userLogout = "user/logout"
    case userRegisterCheck = "user/register_check"
    case userRegister = "user/register"
    case userAuthCode = "user/authcode"
    case userAuthCodeCheck = "user/authcode_check"
    case userEditPassword = "user/edit_password"
    case userEidtPayPassword = "user/edit_paypassword"
    case userBuildPayPassword = "user/build_paypassword"
    
    case home = "home"
    case chatup = "chatup"
    case remind = "remind"
    case userInfo = "user/info"
    case userIssue = "user/issue"
    case userFollow = "user/follow"
    case userFans = "user/fans"
    case userVip = "uservip"
    case userBalance = "user/balance"
    case userBill = "user/bill"
    case userBankCard = "user/bankcard"
    case topicDetail = "topic/detail"
}

typealias ParameterResult = (pathURL: String, parameter: [String: Any]?)

/// URL参数
class URLParameter: NSObject {
    
    /// 登录
    class func userLogin(phone: String, password: String? = nil, authCode: String? = nil) -> ParameterResult {
        if let password = password {
            return (AppPathURLType.userLogin.rawValue, ["phone": phone, "password": password])
        }
        if let authCode = authCode {
            return (AppPathURLType.userLogin.rawValue, ["phone": phone, "authcode": authCode])
        }
        return (AppPathURLType.userLogin.rawValue, ["phone": phone])
    }
    
    /// 退出登录
    class func userLogout() -> ParameterResult {
        return (AppPathURLType.userLogout.rawValue, nil)
    }
    
    /// 验证是否注册
    class func userRegisterCheck(phone: String) -> ParameterResult {
        return (AppPathURLType.userRegisterCheck.rawValue, ["phone": phone])
    }

    /// 注册
    class func userRegister(phone: String, password: String, authCode: String) -> ParameterResult {
        return (AppPathURLType.userRegister.rawValue, ["phone": phone, "password": password, "authcode": authCode])
    }
    
    /// 获取验证码
    class func userAuthCode(phone: String, authCodeType type: UserAuthCodeType) -> ParameterResult {
        return (AppPathURLType.userAuthCode.rawValue, ["phone": phone, "authcode_type": type.codeID])
    }
    
    /// 验证验证码
    class func userAuthCodeCheck(phone: String, authCode: String) -> ParameterResult {
        return (AppPathURLType.userAuthCodeCheck.rawValue, ["phone": phone, "authcode": authCode])
    }
    
    /// 修改登录密码
    class func userEditPassword(phone: String, password: String, authCode: String) -> ParameterResult {
        return (AppPathURLType.userEditPassword.rawValue, ["phone": phone, "password": password, "authcode_type": authCode])
    }
    
    /// 修改支付密码
    class func userEidtPayPassword(phone: String, password: String, authCode: String) -> ParameterResult {
        return (AppPathURLType.userEidtPayPassword.rawValue, ["phone": phone, "password": password, "authcode_type": authCode])
    }
    
    /// 设置支付密码
    class func userBuildPayPassword(phone: String, password: String, authCode: String) -> ParameterResult {
        return (AppPathURLType.userBuildPayPassword.rawValue, ["phone": phone, "password": password, "authcode_type": authCode])
    }
    
}

extension URLParameter {

}
