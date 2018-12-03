//
//  XCInformationInputInforController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/14.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

enum InputInforType {
    /// 昵称
    case nickname
    /// 邮箱
    case email
    /// 地址
    case address
    
    ///navigationItem.title
    var title: String {
        switch self {
        case .nickname: return "修改昵称"
        case .email: return "修改邮箱"
        case .address: return "修改地址"
        }
    }
    
    /// 错误提示信息
    var placeholder: String {
        switch self {
        case .nickname: return "请输入昵称"
        case .email: return "请输入邮箱"
        case .address: return "请输入详细地址"
        }
    }
    
}


/// 信息输入
class XCInformationInputInforController: BaseTableViewController {
    
    @IBOutlet weak var infoTextField: UITextField!
    
    private var info = String()
    
    private var inputInfoType: InputInforType = .nickname
    
    typealias UserInputInfo = (String) -> Void
    
    private var inputInfo: UserInputInfo!
    
    
    public func initWith(inputInfoType type: InputInforType, info: String?, inputInfo: @escaping UserInputInfo) {
        inputInfoType = type
        self.info = info ?? ""
        self.inputInfo = inputInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = inputInfoType.title
        initView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}


extension XCInformationInputInforController {
    private func initView() {
        infoTextField.text = info
        infoTextField.placeholder = inputInfoType.placeholder
        infoTextField.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeaderInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kFooterInSectionHeight
    }
    
}

extension XCInformationInputInforController {
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        UIApplication.shared.keyWindow?.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishAction(_ sender: UIBarButtonItem) {
        switch inputInfoType {
        case .nickname:
            if !(infoTextField.text ?? "").isEmpty {
                popViewController()
            } else {
                MBProgressHUD.show(info: "请输入昵称")
            }
        case .email:
            if (infoTextField.text ?? "").isEmail(showError: true) {
                popViewController()
            }
        case .address:
            if !(infoTextField.text ?? "").isEmpty {
                popViewController()
            } else {
                MBProgressHUD.show(info: "请输入详细地址")
            }
        }
    }
    
    private func popViewController() {
        inputInfo(infoTextField.text!)
        UIApplication.shared.keyWindow?.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
}



