//
//  XCSettingAccountManageController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/11.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 账号管理
class XCSettingAccountManageController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.xcSettingAccountManageCell, for: indexPath)!
        if indexPath.row == 2 {
            cell.avatarImageView.image = #imageLiteral(resourceName: "tool_add")
            cell.avatarImageView.contentMode = .center
            cell.avatarImageView.backgroundColor = UIColor(hex: 0xE9E9E9)
            cell.nicknameLabel.text = "添加新账号"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeaderInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kFooterInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 2 {
            present(InterfaceTool.userLoginController(isSwitch: true), animated: true, completion: nil)
        } else {
            UIApplication.shared.keyWindow?.rootViewController = BaseTabBarController()
        }
    }
    
    


}
