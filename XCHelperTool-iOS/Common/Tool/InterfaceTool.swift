//
//  InterfaceTool.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/14.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 界面跳转
class InterfaceTool: NSObject {
    
    /// 登录/注册
    ///
    /// - Parameter isSwitch: 是否是切换账号(默认：false)
    /// - Returns: UIViewController
    class func userLoginController(isSwitch: Bool = false) -> UIViewController {
        let vc = R.storyboard.xcUser.xcUserLoginController()!
        let navi = BaseNavigationController(rootViewController: vc)
        if isSwitch {
            navi.navigationBar.tag = UserLoginTagType.goToTabBarCtrl.rawValue
        }
        return navi
    }

    /// 验证码
    class func authCodeController(phone: String, authCodeType: UserAuthCodeType) -> UIViewController {
        let vc = R.storyboard.xcUser.xcUserAuthCodeController()!
        vc.initWith(phone: phone, authCodeType: authCodeType)
        return vc
    }
    
    /// 首页
    class func homePageController() -> UIViewController {
        let vc = R.storyboard.xcHome.xcHomeController()!
        return vc
    }
    
    /// 弹幕
    class func chatupController() -> UIViewController {
        let vc = R.storyboard.xcChatUp.xcChatUpController()!
        return vc
    }
    
    /// 提醒事件
    class func remindController() -> UIViewController {
        let vc = R.storyboard.xcRemind.xcRemindController()!
        return vc
    }
    
    /// 用户信息
    class func userInfoController() -> UIViewController {
        let vc = R.storyboard.xcPersonal.xcPersonalController()!
        return vc
    }
    
    /// 发布
    class func userIssueController() -> UIViewController {
        let vc = R.storyboard.xcIssue.xcIssueController()!
        return vc
    }
    
    /// 用户关注
    class func userFollowController() -> UIViewController {
        let vc = XCSecondController()
        return vc
    }
    
    /// 用户粉丝
    class func userFansController() -> UIViewController {
        let vc = XCSecondController()
        return vc
    }
    
    /// 用户VIP
    class func userVipController() -> UIViewController {
        let vc = XCSecondController()
        return vc
    }
    
    /// 用户余额
    class func userBlanceController() -> UIViewController {
        let vc = R.storyboard.xcBalance.xcBalanceController()!
        return vc
    }
    
    /// 用户账单
    class func userBillController() -> UIViewController {
        let vc = R.storyboard.xcBill.xcBillController()!
        return vc
    }
    
    /// 用户银行卡
    class func userBankCardController() -> UIViewController {
        let vc = R.storyboard.xcBankCard.xcBankCardController()!
        return vc
    }
    
    /// 帖子详情
    class func topicDetailController(id: String) -> UIViewController {
        let vc = XCSecondController()
        return vc
    }
    
}
