//
//  XCUserInfoModel.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/12.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 用户信息
class XCUserInfoModel: BaseModelProtocol {

    var json: JSON
    
    var id: Int
    
    var userID: Int
    
    var token: String
    ///  昵称
    var nickname: String
    /// 电话号码
    var phone: String
    ///性别
    var gender: String
    /// 头像
    var avatar: String
    /// 是否实名认证
    var isRealName: Bool
    /// 是否绑定银行卡
    var isBindBank: Bool
    /// 是否设置支付密码
    var isBuildPayPassword: Bool
    /// 是否开通指纹支付
    var isOpenTouchID: Bool
    /// 上次登录时间
    var lastLoginTime: Int
    
    required init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        userID = json["userid"].intValue
        token = json["token"].stringValue
        nickname = json["nickname"].stringValue
        phone = json["phone"].stringValue
        gender = UserGenderType(rawValue: json["gender"].intValue)?.name ?? UserGenderType.none.name
        avatar = json["avatar"].stringValue
        isRealName = json["is_real_name"].intValue == 1
        isBindBank = json["is_bind_bank"].intValue == 1
        isBuildPayPassword = json["is_build_paypassword"].intValue == 1
        isOpenTouchID = json["is_open_touchid"].intValue == 1
        lastLoginTime = json["last_login_time"].intValue
    }
}
