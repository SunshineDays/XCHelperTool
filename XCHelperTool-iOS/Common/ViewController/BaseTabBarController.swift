//
//  BaseTabBarController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/5/31.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 自定义tabbar
class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        initListener()
        initTabBarController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension BaseTabBarController {
    private func initListener() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(shouldLogin(_:)), name: UserNotification.shouldLogin.notification, object: nil)
    }
    
    private func initTabBarController() {
        let ctrls = [BaseNavigationController(rootViewController: R.storyboard.xcHome.xcHomeController()!),
                     BaseNavigationController(rootViewController: XCSecondController()),
                     BaseNavigationController(rootViewController: XCThirdController()),
                     BaseNavigationController(rootViewController: R.storyboard.xcPersonal.xcPersonalController()!)]
        
        let titles = ["首页", "热点", "消息", "我的"]
        let defaultImages = [#imageLiteral(resourceName: " ic_tabbar_home_default"), #imageLiteral(resourceName: "ic_tabbar_profile_default"), #imageLiteral(resourceName: "ic_tabbar_notification_default"), #imageLiteral(resourceName: "icon_tabbar_myup_default")]
        let selectedImages = [#imageLiteral(resourceName: " ic_tabbar_home_selected"), #imageLiteral(resourceName: "ic_tabbar_profile_selected"), #imageLiteral(resourceName: "ic_tabbar_notification_selected"), #imageLiteral(resourceName: "icon_tabbar_myup_selected")]
        for (index, ctrl) in ctrls.enumerated() {
            ctrl.tabBarItem = UITabBarItem(title: titles[index], image: defaultImages[index], selectedImage: selectedImages[index])
        }
        tabBar.tintColor = UIColor.tabBarTint
        viewControllers = ctrls
        selectedIndex = 0
    }
    
    /// 显示登录页
    @objc private func shouldLogin(_ notification: Notification) {
        let vc = InterfaceTool.userLoginController()
        self.selectedViewController?.present(vc, animated: true, completion: nil)
    }
}
