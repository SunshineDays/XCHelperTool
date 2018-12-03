//
//  XCSettingResettingPasswordController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/11.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 密码设置
class XCSettingResettingPasswordController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeaderInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kFooterInSectionHeight
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let isEditPassword = indexPath.row == 0
        let vc = InterfaceTool.authCodeController(phone: "18888888877", authCodeType: isEditPassword  ? .editPassword : .editPayPassword)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
