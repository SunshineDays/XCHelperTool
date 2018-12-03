//
//  XCUserEditPayPasswordController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/6.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 设置/编辑 支付密码
class XCUserEditPayPasswordController: BaseViewController {

    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var passwordView: PayPasswordView!
    
    @IBOutlet weak var nextButton: ThemeNormalButton!
    
    private var phone = String()
    
    private var authCode = String()
    
    private var idCard = String()
    
    private var authCodeType: UserAuthCodeType = .editPayPassword
    /// 上个界面传来的密码
    private var password: String?
    
    public func initWith(phone: String, authCode: String, authCodeType type: UserAuthCodeType, idCard: String? = nil, password: String? = nil) {
        self.phone = phone
        self.authCode = authCode
        authCodeType = type
        self.password = password
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = authCodeType.title
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        passwordView.passwordTextField.becomeFirstResponder()
        IQKeyboardManager.shared.shouldResignOnTouchOutside = false
    }
}

extension XCUserEditPayPasswordController {
    func initView() {
        nextButton.isHidden = password == nil
        passwordView.initWith(lineColor: UIColor.button.selected, height: 45) { (textField) in
            self.nextButton.updateEnabled(textFields: [textField], types: [.password])
            if self.password == nil && (textField.text ?? "").count == 6 {
                let vc = R.storyboard.xcUser.xcUserEditPayPasswordController()!
                vc.initWith(phone: self.phone, authCode: self.authCode, authCodeType: self.authCodeType, idCard: self.idCard, password: textField.text ?? "")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension XCUserEditPayPasswordController {
    private func userBuildPayPasswordData() {
        //        XCUserHandler.userBuildPayPassword(phone: phone, password: passwordTextField.text!, authCode: authCode, success: {
        //
        //        }) { (error) in
        //
        //        }
        MBProgressHUD.show(success: "设置成功")
        PublicTool.popToViewController(2)
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    private func userEditPayPasswordData() {
        //        XCUserHandler.userEditPayPassword(phone: phone, password: passwordTextField.text!, authCode: authCode, success: {
        //
        //        }) { (error) in
        //
        //        }
        MBProgressHUD.show(success: "修改成功")
        PublicTool.popToViewController(4)
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

    }
}

extension XCUserEditPayPasswordController {
    
    @IBAction func nextAction(_ sender: ThemeNormalButton) {
        if passwordView.passwordTextField.text == password {
            UIApplication.shared.keyWindow?.endEditing(true)
            if authCodeType == .editPayPassword {
                userEditPayPasswordData()
            }
            if authCodeType == .buildPayPassword {
                userBuildPayPasswordData()
            }
        } else {
            MBProgressHUD.show(info: "两次密码输入不一致")
        }
    }
}
