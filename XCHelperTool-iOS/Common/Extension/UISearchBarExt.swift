//
//  UISearchBarExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/24.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension UISearchBar {
    /// 占位符
    ///
    /// - Parameters:
    ///   - placeholder: 占位字符串
    ///   - color: 字体颜色
    ///   - font: 字体大小
    func placeholder(_ placeholder: String, color: UIColor? = nil, font: CGFloat? = nil) {
        self.placeholder = placeholder
        let searchField: UITextField = value(forKey: "searchField") as! UITextField
        if let color = color {
            searchField.setValue(color, forKeyPath: "placeholderLabel.textColor")
        }
        if let font = font {
            searchField.setValue(UIFont.systemFont(ofSize: font), forKeyPath: "placeholderLabel.font")
        }
    }
    
    /// 设置背景颜色
    ///
    /// - Parameter color: 背景颜色
    func backgroundColor(_ color: UIColor) {
        backgroundColor = color
        subviews[0].subviews[0].removeFromSuperview()
        subviews[0].subviews[0].backgroundColor = UIColor.clear
    }
    
}
