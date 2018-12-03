//
//  XCSettingPhoneShowController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/27.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 手机号
class XCSettingPhoneShowController: BaseTableViewController {

    @IBOutlet weak var phoneLabel: CustomContentLabel!
    
    @IBOutlet weak var nextButton: ThemeSelectedButton!
    
    @IBAction func nextAction(_ sender: ThemeSelectedButton) {
        
    }
    
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
    
    
}

/// 3D Touch
extension XCSettingPhoneShowController {

    override var previewActionItems: [UIPreviewActionItem] {
        let deleteAction = UIPreviewAction(title: "删除", style: .default) { (action, ctrl) in
            
        }
        let cancelAction = UIPreviewAction(title: "取消", style: .destructive) { (action, ctrl) in
            
        }
        let oneAction = UIPreviewAction(title: "one", style: .default) { (action, ctrl) in
            
        }
        
        let twoAction = UIPreviewAction(title: "two", style: .default) { (action, ctrl) in
            
        }
        let moreAction = UIPreviewActionGroup(title: "更多", style: .default, actions: [oneAction, twoAction])
        
        return [deleteAction, moreAction, cancelAction]
    }
    
}
