//
//  XCHomeController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/1.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 首页
class XCHomeController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 要缓存的控制器
    private var circleCtrl: UIViewController?
    /// 跳转到目标控制器的时间
    private var updateTime: TimeInterval = 0
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let vc = R.storyboard.xcChatUp.xcChatUpController()!
            navigationController?.pushViewController(vc, animated: true)
        case (0, 1):
            let vc = R.storyboard.xcRemind.xcRemindController()!
            navigationController?.pushViewController(vc, animated: true)
        case (0, 2):
            let vc = XCSlideController()
            navigationController?.pushViewController(vc, animated: true)
        case (0, 3):
            let vc = BaseWebViewController()
            navigationController?.pushViewController(vc, animated: true)
        case (0, 4):
            let vc = R.storyboard.xcTakeOut.xcTakeOutShopController()!
            navigationController?.pushViewController(vc, animated: true)
        case (0, 5):
            let vc = R.storyboard.xcTakeOut.xcTakeOutController()!
            navigationController?.pushViewController(vc, animated: true)
        case (0, 6):
            let vc = XCFixedHeaderController()
            navigationController?.pushViewController(vc, animated: true)
        case (0, 7):
            let vc = XCThirdController()
            navigationController?.pushViewController(vc, animated: true)
        case (0, 8):
            let vc = XCSecondController()
            navigationController?.pushViewController(vc, animated: true)
        case (0, 9):
            "17621746288".call()
        case (0, 10):
            let nowTime = Date().timeIntervalSince1970
            if circleCtrl == nil || nowTime > updateTime + 60 * 5 {
                circleCtrl = R.storyboard.xcCircle.xcCircleController()
            }
            navigationController?.pushViewController(circleCtrl!, animated: true)
            updateTime = nowTime
        case (0, 11):
            let vc = XCBluetoothController()
            navigationController?.pushViewController(vc, animated: true)
        case (0, 12):
            let vc = XCBluetoothPeripheralController()
            navigationController?.pushViewController(vc, animated: true)
        case (0, 13):
            navigationController?.pushViewController(XCHomeProgressController(), animated: true)
        default:
            break
        }
    }
    
}
