//
//  XCUserAuthCodeController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/7.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 输入验证码
class XCUserAuthCodeController: BaseViewController {
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var authCodeTextField: MaxCountTextField!
    
    @IBOutlet weak var authCodeButton: AuthCodeButton!
    
//    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginButton: ThemeNormalButton!
    
    private var phone = String()
    
    private var authCodeType: UserAuthCodeType = .login
    
    public func initWith(phone: String, authCodeType type: UserAuthCodeType) {
        self.phone = phone
        authCodeType = type
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    deinit {
        authCodeButton.isTimerFire = false
    }
}

extension XCUserAuthCodeController {
    private func initView() {
        loginButton.setTitle(authCodeType == .login ? "登录" : "下一步", for: .normal)
        phoneLabel.text = "+86 " + ((authCodeType == .findPassword || authCodeType == .register || authCodeType == .login) ? phone : phone.mobileSecurity)
        authCodeTextField.customDelegate = self
        authCodeTextField.maxCountType = .authCode
    }

}

extension XCUserAuthCodeController {
    
    private func userLoginData() {
//        XCUserHandler.userLogin(phone: phone, authCode: authCodeTextField.text!, success: { (model) in
//
//        }) { (error) in
//
//        }
//
        if navigationController?.navigationBar.tag == UserLoginTagType.goToTabBarCtrl.rawValue {
            UIApplication.shared.keyWindow?.rootViewController = BaseTabBarController()
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func userAuthCodeData(sender: AuthCodeButton) {
        XCUserHandler.userAuthCode(phone: phone, authCodeType: authCodeType, success: { [weak self] in
            MBProgressHUD.show(success: "验证码发送成功")
            sender.isTimerFire = true
            self?.authCodeTextField.becomeFirstResponder()
        }) { (error) in
            
        }
    }
    
    private func userAuthCodeCheckData() {
//        XCUserHandler.userAuthCodeCheck(phone: phone, authCode: authCodeTextField.text!, success: {[weak self] in
//            self?.showCtrl()
//        }) { (error) in
//            MBProgressHUD.show(info: error.localizedDescription)
//        }
        
        showCtrl()
        
    }
}

extension XCUserAuthCodeController: CustomTextFieldDelegate {
    func customTextFieldEditValueChanged(_ textField: UITextField) {
        loginButton.updateEnabled(textFields: [textField], types: [.authCode])
    }
}


extension XCUserAuthCodeController {
    
    /// 重新获取验证码
    @IBAction func authCodeAction(_ sender: AuthCodeButton) {
        userAuthCodeData(sender: sender)
    }
    
    /// 下一步
    @IBAction func loginAction(_ sender: ThemeNormalButton) {
        UIApplication.shared.keyWindow?.endEditing(true)
        userAuthCodeCheckData()
    }
    
    private func showCtrl() {
        switch authCodeType {
        case .login: //登录
            userLoginData()
        case .register, .findPassword, .editPassword: //注册、找回登录密码、修改登录密码
            let vc = R.storyboard.xcUser.xcUserEditPasswordController()!
            vc.initWith(phone: phone, authCode: authCodeTextField.text!, authCodeType: authCodeType)
            navigationController?.pushViewController(vc, animated: true)
        case .editPayPassword: //修改支付密码
            let vc = R.storyboard.xcUser.xcUserCheckIDCardController()!
            vc.initWith(phone: phone, authCode: authCodeTextField.text!, authCodeType: authCodeType)
            navigationController?.pushViewController(vc, animated: true)
        case .buildPayPassword: //设置支付密码
            let vc = R.storyboard.xcUser.xcUserEditPayPasswordController()!
            vc.initWith(phone: phone, authCode: authCodeTextField.text!, authCodeType: authCodeType)
            navigationController?.pushViewController(vc, animated: true)
        case .bindBank: //绑定银行卡
            break
        case .editPhone: //更换手机号
            break
        }
    }
    
    
}

