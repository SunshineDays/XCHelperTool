//
//  XCUserEditPasswordController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/15.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 修改/设置登录密码
class XCUserEditPasswordController: BaseTableViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!

    @IBOutlet weak var finishButton: ThemeNormalButton!
    
    
    private var phone = String()
    
    private var authCode = String()
    
    private var authCodeType: UserAuthCodeType = .editPassword
    
    public func initWith(phone: String, authCode: String, authCodeType type: UserAuthCodeType) {
        self.phone = phone
        self.authCode = authCode
        authCodeType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = authCodeType.title
        initView()
    }

}

extension XCUserEditPasswordController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeaderInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kFooterInSectionHeight
    }
}

extension XCUserEditPasswordController {
    private func initView() {
        passwordTextField.addTarget(self, action: #selector(editValueChanged(_:)), for: .editingChanged)
        password2TextField.addTarget(self, action: #selector(editValueChanged(_:)), for: .editingChanged)
        if authCodeType == .register {
            finishButton.setTitle("完成注册", for: .normal)
        }
        if authCodeType == .findPassword || authCodeType == .editPassword {
            finishButton.setTitle("确认", for: .normal)
        }
    }
}

extension XCUserEditPasswordController {
    private func userEditPassworData(type: UserAuthCodeType) {
        XCUserHandler.userEditPassword(phone: phone, password: passwordTextField.text!, authCode: authCode, success: { [weak self] in
            MBProgressHUD.show(success: "修改成功")
            if type == .findPassword {
                self?.navigationController?.popToRootViewController(animated: true)
                
            } else {
                PublicTool.popToViewController(3)
            }
        }) { (error) in
            
        }
    }
    
    private func userRegisterData() {
        //        XCUserHandler.userRegister(phone: phone, password: passwordTextField.text!, authCode: authCode, success: { (model) in
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


extension XCUserEditPasswordController {
 
    @objc func editValueChanged(_ textField: UITextField) {
        finishButton.updateEnabled(textFields: [passwordTextField, password2TextField], types: [.password, .password])
    }
    
    @IBAction func finishAction(_ sender: ThemeNormalButton) {
        if passwordTextField.text == password2TextField.text {
            UIApplication.shared.keyWindow?.endEditing(true)
            switch authCodeType {
            case .findPassword:
                //                userEditPassworData(type: .findPassword)
                MBProgressHUD.show(success: "修改成功")
                navigationController?.popToRootViewController(animated: true)
            case .editPassword:
                //                userEditPassworData(type: .editPassword)
                MBProgressHUD.show(success: "修改成功")
                PublicTool.popToViewController(3)
            case .register:
                userRegisterData()
            default: break
            }
        } else {
            MBProgressHUD.show(info: "两次密码输入不一致")
        }
    }

}
