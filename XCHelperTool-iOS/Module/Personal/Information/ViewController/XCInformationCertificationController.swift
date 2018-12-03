//
//  XCInformationCertificationController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/15.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 实名认证
class XCInformationCertificationController: BaseTableViewController {

    @IBOutlet weak var nameTextField: MaxCountTextField!
    
    @IBOutlet weak var idCardTextField: IDCardTextField!
    
    @IBOutlet weak var confirmButton: ThemeNormalButton!
    
    typealias CertificationSuccessType = () -> Void
    
    private var successType: CertificationSuccessType!
    
    public func initWith(successType: @escaping CertificationSuccessType) {
        self.successType = successType
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

extension XCInformationCertificationController {
    
    private func initView() {
        nameTextField.customDelegate = self
        nameTextField.maxCountType = .other
        idCardTextField.customDelegate = self
    }
}

extension XCInformationCertificationController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeaderInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kFooterInSectionHeight
    }
}

extension XCInformationCertificationController: CustomTextFieldDelegate {
    func customTextFieldEditValueChanged(_ textField: UITextField) {
        confirmButton.updateEnabled(textFields: [nameTextField, idCardTextField], types: [.other, .idCard])
    }
}

extension XCInformationCertificationController {
    
    @IBAction func confirmAction(_ sender: UIButton) {
        successType()
        MBProgressHUD.show(success: "实名认证成功")
        navigationController?.popViewController(animated: true)
    }
}
