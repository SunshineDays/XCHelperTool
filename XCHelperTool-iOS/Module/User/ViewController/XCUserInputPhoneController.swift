//
//  XCUserInputPhoneController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/15.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 输入手机号码（忘记密码）
class XCUserInputPhoneController: BaseTableViewController {

    @IBOutlet weak var phoneTextField: MobileTextField!
    
    @IBOutlet weak var nextButton: ThemeNormalButton!
    
    private var authCodeType: UserAuthCodeType = .findPassword
    
    public func initWith(authCodeType type: UserAuthCodeType = .findPassword) {
        authCodeType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = authCodeType.title
        
        phoneTextField.customDelegate = self
    }
    
}

extension XCUserInputPhoneController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeaderInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kFooterInSectionHeight
    }
}

extension XCUserInputPhoneController {
    private func userAuthCodeData() {
        //        XCUserHandler.userAuthCode(phone: phoneTextField.text ?? "", authCodeType: authCodeType, success: {
        //
        //        }) { (error) in
        //
        //        }
        
        let vc = InterfaceTool.authCodeController(phone: phoneTextField.text!, authCodeType: .findPassword)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension XCUserInputPhoneController : CustomTextFieldDelegate {
    func customTextFieldEditValueChanged(_ textField: UITextField) {
        nextButton.updateEnabled(textFields: [textField], types: [.phone])
    }
}

extension XCUserInputPhoneController {
    
    @IBAction func nextAction(_ sender: ThemeNormalButton) {
        if phoneTextField.text!.isMobile(showError: true) {
            userAuthCodeData()
        }
    }
    
}
