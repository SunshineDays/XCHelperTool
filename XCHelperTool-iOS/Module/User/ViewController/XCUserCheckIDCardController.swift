//
//  XCUserCheckIDCardController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/12.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 验证身份信息
class XCUserCheckIDCardController: BaseTableViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var idCardTextField: IDCardTextField!
    
    @IBOutlet weak var nextButton: ThemeNormalButton!
    
    private var phone = String()
    
    private var authCode = String()
    
    private var authCodeType: UserAuthCodeType = .editPayPassword
    
    public func initWith(phone: String, authCode: String, authCodeType type: UserAuthCodeType) {
        self.phone = phone
        self.authCode = authCode
        authCodeType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension XCUserCheckIDCardController {
    private func initView() {
        idCardTextField.customDelegate = self
    }
    
}

extension XCUserCheckIDCardController: CustomTextFieldDelegate {
    func customTextFieldEditValueChanged(_ textField: UITextField) {
        nextButton.updateEnabled(textFields: [textField], types: [.idCard])
    }
}

extension XCUserCheckIDCardController {
    
    @IBAction func nextAction(_ sender: ThemeNormalButton) {
        if idCardTextField.text!.isIDCard(showError: true) {
            let vc = R.storyboard.xcUser.xcUserEditPayPasswordController()!
            vc.initWith(phone: phone, authCode: authCode, authCodeType: authCodeType, idCard: idCardTextField.text!)
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
