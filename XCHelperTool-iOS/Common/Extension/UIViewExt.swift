//
//  UIViewExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/28.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension UIView {
    
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    var width: CGFloat {
        get {
            return frame.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return frame.width
        }
        set {
            frame.size.height = newValue
        }
    }
    
    var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }
    
    var centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center.y = newValue
        }
    }
    
    /// view当前所在的控制器
    var viewController: UIViewController? {
        var next: UIView? = self
        repeat {
            if let nextResponder = next?.next, nextResponder is UIViewController {
                return nextResponder as? UIViewController
            }
            next = next?.superview
        } while next != nil
        return nil
    }
    
//    func copyView() -> Any? {
//        let tempArchive = NSKeyedArchiver.archivedData(withRootObject: self)
//        let view = NSKeyedUnarchiver.unarchiveObject(with: tempArchive)
//        return view
//    }
    
    
}

extension UIView {
    // MARK: - 可视化设置 添加圆角和边框(性能差) 性能高的:addCornerRadius
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// 像素宽度
    @IBInspectable var borderWidthPixel: CGFloat {
        get {
            return layer.borderWidth * UIScreen.main.scale
        }
        set {
            layer.borderWidth = newValue / UIScreen.main.scale
        }
    }
    
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let c = layer.borderColor {
                return UIColor(cgColor: c)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
