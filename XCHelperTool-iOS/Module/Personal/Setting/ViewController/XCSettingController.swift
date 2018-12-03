//
//  XCSettingController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/11.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 设置
class XCSettingController: BaseTableViewController {

    @IBOutlet weak var phoneLabel: CustomContentLabel!
    @IBOutlet weak var cacheLabel: CustomContentLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cacheLabel.text = String(format: "%.2fM", CGFloat(KingfisherManager.shared.cache.maxDiskCacheSize) / 1024 / 1024)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 3 ? 40 : kHeaderInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kFooterInSectionHeight
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        if traitCollection.forceTouchCapability == .available{
//            registerForPreviewing(with: self, sourceView: cell)
//        }
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (2, 0):
            presentAlertController(title: "确定要清除缓存嘛？", message: nil, confirmTitle: "清除", cancelTitle: "取消", confirmHandler: { (action) in
                let cache = KingfisherManager.shared.cache
                cache.clearDiskCache()//清除硬盘缓存
                cache.clearMemoryCache()//清理网络缓存
                cache.cleanExpiredDiskCache()//清理过期的，或者超过硬盘限制大小的
                self.cacheLabel.text = "0.00M"
            }, cancelHandler: nil)
        case (3, 0):
            navigationController?.popToRootViewController(animated: true)
            XCUserHandler.userLogout(success: { (json) in
                
            }) { (error) in
                
            }
        default:
            break
        }
    }

}

/// 3D Touch
extension XCSettingController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let vc = XCSettingPhoneShowController()
        vc.view.backgroundColor = UIColor.blue
        return vc
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        let vc = XCSettingPhoneShowController()
        vc.view.backgroundColor = UIColor.yellow
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
