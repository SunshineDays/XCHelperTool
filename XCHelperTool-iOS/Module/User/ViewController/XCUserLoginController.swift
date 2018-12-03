//
//  XCUserLoginController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/6.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

enum UserLoginTagType: Int {
    /// 关闭登录流程
    case dismissCtrl = 100
    /// 切换用户，关闭登录流程，并且跳转到BaseTabBarController
    case goToTabBarCtrl = 101
}

/// 验证码 登录/注册
class XCUserLoginController: BaseViewController {

    @IBOutlet weak var registerButton: UIBarButtonItem!
    
    @IBOutlet weak var authCodeLoginView: UIView!
    
    @IBOutlet weak var phoneTextField: MobileTextField!
    
    @IBOutlet weak var passwordLoginView: UIView!
    
    @IBOutlet weak var phone2TextField: MobileTextField!
    
    @IBOutlet weak var passwordTextField: MaxCountTextField!
    
    @IBOutlet weak var findPasswordButton: UIButton!
    
    @IBOutlet weak var authCodeButton: ThemeNormalButton!
    
    @IBOutlet weak var loginButton: ThemeNormalButton!
    
    @IBOutlet weak var changeButton: UIButton!

    private var lastPhoneTextCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.title = ""
        initView()
    }
}

extension XCUserLoginController {
    
    private func initView() {
        phoneTextField.customDelegate = self
        phone2TextField.customDelegate = self
        passwordTextField.customDelegate = self
        passwordTextField.maxCountType = .password
    }
    
}

extension XCUserLoginController {
    private func userRegistherCheckData() {
//        XCUserHandler.userRegisterCheck(phone: phoneTextField.text!, success: { [weak self] (isExist) in
//            self?.userAuthCodeData(authCodeType: isExist ? .login : .register)
//        }) { (error) in
//
//        }
        
        userAuthCodeData(authCodeType: .register)
    }
    
    private func userAuthCodeData(authCodeType: UserAuthCodeType) {
//        XCUserHandler.userAuthCode(phone: phoneTextField.text ?? "", authCodeType: authCodeType, success: {
//
//        }) { (error) in
//
//        }
        let vc = InterfaceTool.authCodeController(phone: phoneTextField.text!, authCodeType: .register)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func userLoginData() {
//        XCUserHandler.userLogin(phone: phone2TextField.text!, password: passwordTextField.text!, success: { (model) in
//
//        }) { (error) in
//
//        }
        
        if navigationController?.navigationBar.tag == UserLoginTagType.goToTabBarCtrl.rawValue {
            UIApplication.shared.keyWindow?.rootViewController = BaseTabBarController()
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
}


extension XCUserLoginController: CustomTextFieldDelegate {
    func customTextFieldEditValueChanged(_ textField: UITextField) {
        if textField == phoneTextField {
            authCodeButton.updateEnabled(textFields: [phoneTextField], types: [.phone])
        } else {
            loginButton.updateEnabled(textFields: [phone2TextField, passwordTextField], types: [.phone, .password])
        }
    }
}


extension XCUserLoginController {
    
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        UIApplication.shared.keyWindow?.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    // 用户协议
    @IBAction func userProtocolAction(_ sender: UIButton) {
        
    }
    
    /// 切换登录方式
    @IBAction func authCodeOrPasswordAction(_ sender: UIButton) {
        changeToAuthCode()
    }
    
    
    @IBAction func registerAction(_ sender: UIBarButtonItem) {
        changeToAuthCode()
    }
    
    private func changeToAuthCode() {
        UIApplication.shared.keyWindow?.endEditing(true)
        changeButton.setTitle(authCodeLoginView.isHidden ? "账号密码登录" : "短信验证码登录", for: .normal)
        authCodeLoginView.isHidden = !authCodeLoginView.isHidden
        passwordLoginView.isHidden = !passwordLoginView.isHidden
        findPasswordButton.isHidden = !findPasswordButton.isHidden
        //        registerButton.isHidden = !registerButton.isHidden
        registerButton.title = authCodeLoginView.isHidden ? "注册" : ""
    }
    
    // 验证码登录
    @IBAction func authCodeAction(_ sender: ThemeNormalButton) {
        if phoneTextField.text!.isMobile(showError: true) {
            userRegistherCheckData()
        }
    }
    @IBAction func loginAction(_ sender: ThemeNormalButton) {
        if phone2TextField.text!.isMobile(showError: true) {
            userLoginData()
        }
    }
}

extension XCUserLoginController {
    /// 是否是验证码登录
    private func isAuthCodeLogin() -> Bool {
        return authCodeLoginView.isHidden
    }    
    
    
}


