//
//  UserToken.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/7.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

enum UserInfoKey: String {
    /// 用户信息模型
    case userInfoModel = "userInfoModel"
    
}

/// 用户信息
class UserToken: NSObject {
    
    /// 保存
    class func save(value: Any?, forKey key: UserInfoKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    /// 读取
    class func read(forKey key: UserInfoKey) -> Any? {
//        return UserDefaults.standard.string(forKey: key.rawValue)
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
    
    static let shared = UserToken()
    
    /// 是否登录
    var isLogin: Bool {
        if let userInfoModel = userInfoModel {
            return !userInfoModel.token.isEmpty
        }
        return false
    }

    /// 用户信息
    var userInfoModel: XCUserInfoModel? {
        guard let json = UserToken.read(forKey: .userInfoModel) else { return nil }
        if isLogin {
            let userInfo = XCUserInfoModel(json: JSON(parseJSON: json as! String))
            return userInfo
        } else {
            return nil
        }        
    }
    
    /// 更新用户信息
    func update(userInfo: XCUserInfoModel) {
        let json = userInfo.json.description
        UserToken.save(value: json, forKey: .userInfoModel)
    }
    
    /// 清除用户信息
    func clearUserInfo() {
        UserToken.save(value: nil, forKey: .userInfoModel)
    }
    
}
