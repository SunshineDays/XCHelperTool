//
//  XCBalanceRechargeController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/28.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 充值
class XCBalanceRechargeController: UITableViewController {

    @IBOutlet weak var wayImageView: UIImageView!
    
    @IBOutlet weak var wayNameLabel: UILabel!
    
    @IBOutlet weak var moneyTextField: UITextField!
    
    @IBOutlet weak var confirmButton: ThemeNormalButton!
    
    @IBAction func confirmAction(_ sender: ThemeNormalButton) {
        
    }
    
    @IBAction func recordAction(_ sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moneyTextField.placeholder("请输入充值金额", font: 17)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeaderInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kFooterInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
