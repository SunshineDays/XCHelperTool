//
//  XCUserHandler.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/13.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 用户
class XCUserHandler: BaseHandler {

    /// 登录
    class func userLogin(phone: String, password: String? = nil, authCode: String? = nil, success: @escaping (XCUserInfoModel) -> Void, failed: @escaping FailedBlock) {
        let parameter = URLParameter.userLogin(phone: phone, password: password)
        RequestTool.request(parameter: parameter, success: { (json) in
            let model = XCUserInfoModel(json: json)
            UserToken.shared.update(userInfo: model)
            success(model)
        }) { (error) in
            failed(error)
        }
    }
    
    /// 退出登录
    class func userLogout(success: @escaping (JSON) -> Void, failed: @escaping FailedBlock) {
        let parameter = URLParameter.userLogout()
        RequestTool.request(parameter: parameter, success: { (json) in
            success(json)
        }) { (error) in
            failed(error)
        }
    }
    
    /// 验证是否注册
    class func userRegisterCheck(phone: String, success: @escaping (Bool) -> Void, failed: @escaping FailedBlock) {
        let parameter = URLParameter.userRegisterCheck(phone: phone)
        RequestTool.request(parameter: parameter, success: { (json) in
            success(false)
        }) { (error) in
            failed(error)
        }
    }
    
    /// 注册
    class func userRegister(phone: String, password: String, authCode: String, success: @escaping (XCUserInfoModel) -> Void, failed: @escaping FailedBlock) {
        let parameter = URLParameter.userRegister(phone: phone, password: password, authCode: authCode)
        RequestTool.request(parameter: parameter, success: { (json) in
            
        }) { (error) in
            
        }
    }
    
    /// 获取验证码
    class func userAuthCode(phone: String, authCodeType: UserAuthCodeType, success: @escaping() -> Void, failed: @escaping FailedBlock) {
        let parameter = URLParameter.userAuthCode(phone: phone, authCodeType: authCodeType)
        RequestTool.request(parameter: parameter, success: { (json) in
            success()
        }) { (error) in
            failed(error)
        }
    }
    
    /// 验证验证码
    class func userAuthCodeCheck(phone: String, authCode: String, success: @escaping() -> Void, failed: @escaping FailedBlock) {
        let parameter = URLParameter.userAuthCodeCheck(phone: phone, authCode: authCode)
        RequestTool.request(parameter: parameter, success: { (json) in
            success()
        }) { (error) in
            failed(error)
        }
    }
    
    /// 修改登录密码
    class func userEditPassword(phone: String, password: String, authCode: String, success: @escaping() -> Void, failed: @escaping FailedBlock) {
        let parameter = URLParameter.userEditPassword(phone: phone, password: password, authCode: authCode)
        RequestTool.request(parameter: parameter, success: { (json) in
            
        }) { (error) in
            
        }
    }
    
    /// 修改支付密码
    class func userEditPayPassword(phone: String, password: String, authCode: String, success: @escaping() -> Void, failed: @escaping FailedBlock) {
        let parameter = URLParameter.userEidtPayPassword(phone: phone, password: password, authCode: authCode)
        RequestTool.request(parameter: parameter, success: { (json) in
            
        }) { (error) in
            
        }
    }
    
    /// 设置支付密码
    class func userBuildPayPassword(phone: String, password: String, authCode: String, success: @escaping() -> Void, failed: @escaping FailedBlock) {
        let parameter = URLParameter.userBuildPayPassword(phone: phone, password: password, authCode: authCode)
        RequestTool.request(parameter: parameter, success: { (json) in
            
        }) { (error) in
            
        }
    }
    
}
