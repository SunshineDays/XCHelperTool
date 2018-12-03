//
//  CGFloatExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/6.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension CGFloat {
    /// 对应的像素值
    var pixel: CGFloat {
        return self / UIScreen.main.scale
    }
}

//extension CALayer {
//    /// 像素宽度
//    @IBInspectable var borderWidthPixel: CGFloat {
//        get {
//            return borderWidth * UIScreen.main.scale
//        } set {
//            borderWidth = newValue / UIScreen.main.scale
//        }
//    }
//}
//
//extension NSLayoutConstraint {
//    /// 约束
//    @IBInspectable var pixel: CGFloat {
//        get {
//            return constant * UIScreen.main.scale
//        }
//        set {
//            constant = newValue / UIScreen.main.scale
//        }
//    }
//}
