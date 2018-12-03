//
//  PayTool.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/6.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit
import LocalAuthentication

class PayTool: NSObject {

    class func pay(pay: @escaping (_ password: String) -> ()) {
//        if let userInfoModel = UserToken.shared.userInfoModel {
            /// 设置了支付密码
        
//            if userInfoModel.isBuildPayPassword {
        
        if true {
                let context = LAContext()
                var error: NSError? = nil
                
                //判断设备支持状态和用户是否开通指纹支付
//                let isTouchID = context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) && userInfoModel.isOpenTouchID
            
            let isTouchID = context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) && false
            
                //支持指纹验证且用户开通
                if isTouchID {
                    context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "请验证已有指纹，用于支付", reply: { (success, error) in
                        if success {
                            DispatchQueue.main.async {
                                pay("123123")
                            }
                        }
                        else {
                            switch (error as! LAError).code {
                            //用户取消验证Touch ID
                            case LAError.userCancel: break
                            default:
                                DispatchQueue.main.async {
                                    let vc = R.storyboard.xcPay.xcPayInputPasswordController()!
                                    vc.initWith(payPasswordBlock: { (password) in
                                        pay(password)
                                    })
                                    UIApplication.shared.keyWindow?.rootViewController?.addChild(vc)
                                    UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(vc.view)
                                }
                            }
                        }
                    })
                }
                //不支持指纹验证/用户没有开通
                else {
                    DispatchQueue.main.async {
                        let vc = R.storyboard.xcPay.xcPayInputPasswordController()!
                        vc.initWith(payPasswordBlock: { (password) in
                            pay(password)
                        })
                        UIApplication.shared.keyWindow?.rootViewController?.addChild(vc)
                        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(vc.view)
                    }
                }
            }
                /// 没有设置支付密码
            else {
//                let vc = R.storyboard.xcPay.xcPayInputPasswordController()!
//                UIApplication.shared.keyWindow?.rootViewController?.addChildViewController(vc)
//                UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(vc.view)
            }
//        }
    }
    
    private class func showAlertController() {
        let alertController = UIAlertController(title: "确定要退出吗？", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "输入密码", style: .default, handler: { (action) in
            
        }))
        alertController.addAction(UIAlertAction(title: "退出", style: .cancel, handler: { (action) in
            
        }))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    
}
