//
//  XCSettingAboutController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/27.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 关于
class XCSettingAboutController: BaseTableViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var versionLabel: UILabel!
    
    private lazy var footerView: XCSettingAboutFooterView = {
        let view = R.nib.xcSettingAboutFooterView.firstView(owner: nil)!
        view.frame = CGRect(x: 0, y: tableView.frame.height - 71 - kNavigationHeight - kBottomMargin, width: tableView.frame.width, height: 71)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(footerView)
        logoImageView.layer.cornerRadius = 6
        logoImageView.layer.masksToBounds = true
        
        versionLabel.text = AppInfoTool.appName() + " " + AppInfoTool.appVersion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


}
