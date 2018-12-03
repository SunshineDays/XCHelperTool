//
//  XCPayInputPasswordController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/6.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 支付弹窗 输入支付密码
class XCPayInputPasswordController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var backgroundViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordView: PayPasswordView!

    @IBOutlet weak var passwordViewHeightConstraint: NSLayoutConstraint!
    
    private let viewTopConstraint = kScreenHeight * (1 - 51 / 72)

    typealias PayPasswordBlock = (_ password: String) -> Void
    
    private var payPasswordBlock: PayPasswordBlock?
    
    public func initWith(payPasswordBlock: @escaping PayPasswordBlock) {
        self.payPasswordBlock = payPasswordBlock
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.shouldResignOnTouchOutside = false
        initView()
    }
}

extension XCPayInputPasswordController {
    private func initView() {
        backgroundView.frame.origin.y = kScreenHeight
        
        passwordViewHeightConstraint.constant = (kScreenWidth - passwordView.frame.origin.x * 2) / 6
        
        passwordView.initWith(lineColor: UIColor.line, height: passwordViewHeightConstraint.constant) { (textField) in
            if (textField.text ?? "").count == 6 {
                self.payPasswordBlock?(textField.text!)
            }
        }
        
        UIView.animate(withDuration: 0.2) {
            self.backgroundViewTopConstraint.constant = self.viewTopConstraint
            self.backgroundView.frame.origin.y = self.viewTopConstraint
        }
    }
}

extension XCPayInputPasswordController {
    @IBAction func closeAction(_ sender: UIButton) {
        dismissCtrl(withDuration: 0.2)
    }
    
    @IBAction func forgetAction(_ sender: UIButton) {
        dismissCtrl(withDuration: 0)
        let vc = InterfaceTool.authCodeController(phone: UserToken.shared.userInfoModel?.phone ?? "", authCodeType: .editPayPassword)
        PublicTool.rootViewController().pushViewController(vc, animated: true)
    }
    
    private func dismissCtrl(withDuration duration: TimeInterval) {
        IQKeyboardManager.shared.shouldResignOnTouchOutside = false
        UIApplication.shared.keyWindow?.endEditing(true)
        UIView.animate(withDuration: duration, animations: {
            self.backgroundView.frame.origin.y = kScreenHeight
            self.view.alpha = 0
        }) { (finish) in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
}
