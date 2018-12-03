//
//  UIColorExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/5/31.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 主题颜色(0x1977CC)
    static let theme = UIColor(hex: 0x1977CC)
    
    /// TabBar选中状态字体颜色
    static let tabBarTint = UIColor(hex: 0xFF7601)
    
    /// 导航栏默认颜色
    static let navigationBarDefault = (background: UIColor(hex: 0xFF7601),
                                            title: UIColor.white,
                                             tint: UIColor.white)
    
    /// 按钮颜色
    static let button = (normal: UIColor(hex: 0xFFB774),
                       selected: UIColor(hex: 0xFF7601))
    
    /// 分割线线的颜色 系统默认(0xC8C7CC)
    static let line = UIColor(hex: 0xC8C7CC)
    
    /// 黑灰色背景(0x36353A)
    static let blackGray = UIColor(hex: 0x36353A)
    
}

extension UIColor {
    /// 颜色转图片
    public func convertToImage(width: CGFloat = 1.0, height: CGFloat = 1.0) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIColor {
    /// hex
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red   = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8)  / 255.0
        let blue  = CGFloat(hex & 0x0000FF)         / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// RGBA
    convenience init(rgba: String, alpha: CGFloat = 1.0) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        
        var index = rgba.startIndex
        if rgba.hasPrefix("#") {
            index   = rgba.index(rgba.startIndex, offsetBy: 1)
        }
        let hex     = String(rgba[index...])
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
            }
        }
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
   
}


