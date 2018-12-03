//
//  BaseNavigationController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/5/31.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 自定义导航栏
class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        navigationBar.barTintColor = UIColor.navigationBarDefault.background
        navigationBar.tintColor = UIColor.navigationBarDefault.tint
        setNaviBarApperence()
    }
    
    func setNaviBarApperence() {
        WRNavigationBar.wr_widely()
        // 设置导航栏默认的背景颜色
        WRNavigationBar.wr_setDefaultNavBarBarTintColor(UIColor.navigationBarDefault.background)
        // 设置导航栏标题默认颜色
        WRNavigationBar.wr_setDefaultNavBarTitleColor(UIColor.navigationBarDefault.title)
        // 设置导航栏左右按钮的默认颜色
        WRNavigationBar.wr_setDefaultNavBarTintColor(UIColor.navigationBarDefault.tint)
        // 是否隐藏底部分割线
        WRNavigationBar.wr_setDefaultNavBarShadowImageHidden(false)
        // 状态栏字体颜色
//        UIApplication.shared.statusBarStyle = .lightContent
        navigationBar.setBackItemImage(R.image.navigationbar_goback())
        
        
//        if #available(iOS 11.0, *) {
//            navigationBar.prefersLargeTitles = true
//        } else {
//            // Fallback on earlier versions
//        }
        
    }

    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.tabBarController?.tabBar.isHidden = true
        }
        super.pushViewController(viewController, animated: animated)
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension UINavigationBar {
    /// 设置返回按钮左边的图片
    func setBackItemImage(_ image: UIImage?) {
        backIndicatorImage = image
        backIndicatorTransitionMaskImage = image
    }
}


extension BaseNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return children.count > 1
    }
}
