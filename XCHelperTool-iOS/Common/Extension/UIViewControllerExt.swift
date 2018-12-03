//
//  UIViewControllerExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/3.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlertController(title: String?,
                              message: String?,
                         confirmTitle: String = "确定",
                          cancelTitle: String = "取消",
                       confirmHandler: ((UIAlertAction) -> Void)?,
                        cancelHandler: ((UIAlertAction) -> Void)?)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: confirmTitle, style: .default, handler: confirmHandler))
        alertController.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        present(alertController, animated: true, completion: nil)
    }

}

extension UIViewController {
    
    /// 导航栏背景颜色
    func setNaviBarBackgroundColor(_ color: UIColor) {
        wr_setNavBarBarTintColor(color)
    }
    
    /// 导航栏标题颜色
    func setNaviBarTitleColor(_ color: UIColor) {
        wr_setNavBarTitleColor(color)
    }
    
    /// 导航栏左右按钮颜色
    func setNaviBarTintColor(_ color: UIColor) {
        wr_setNavBarTintColor(color)
    }
    
    /// 是否隐藏导航栏底部的黑线
    func setNaviBarShadowImage(isHidden: Bool) {
        wr_setNavBarShadowImageHidden(isHidden)
    }
    
    /// 设置透明度
    func setNaviBarAlpha(_ alpha: CGFloat) {
        wr_setNavBarBackgroundAlpha(alpha)
    }
    
    /// 设置状态栏
    func setStatusBarStyle(_ style: UIStatusBarStyle) {
        UIApplication.shared.statusBarStyle = style
    }
    
    /// 把导航栏设置为默认的颜色（所有元素）
    func setNaviBarDefaultStyle() {
        setNaviBarBackgroundColor(UIColor.navigationBarDefault.background)
        setNaviBarTitleColor(UIColor.navigationBarDefault.title)
        setNaviBarTintColor(UIColor.navigationBarDefault.tint)
        setNaviBarShadowImage(isHidden: false)
        setNaviBarAlpha(1)
        setStatusBarStyle(.lightContent)
    }
}
