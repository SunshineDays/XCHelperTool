//
//  UIButtonExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/6.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension UIButton {
    /// 设置背景颜色
    func setBackgroundColor(_ color: UIColor, forState state: UIControl.State) {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        setBackgroundImage(image, for: state)
    }
}

extension UIButton {
    
    /****************** 可视化设置正常状态背景色 ************/
    
    @IBInspectable var normalBackgourndColor: UIColor? {
        get {
            return nil
        }
        set {
            if let newValue = newValue {
                setBackgroundColor(newValue, forState: .normal)
            }
        }
    }
    
    @IBInspectable var normalTitleColor: UIColor? {
        get {
            return nil
        }
        set {
            if let newValue = newValue {
                setTitleColor(newValue, for: .normal)
            }
        }
    }
    
    @IBInspectable var selectedBackgroundColor: UIColor? {
        get {
            return nil
        }
        set {
            if let newValue = newValue {
                setBackgroundColor(newValue, forState: .selected)
            }
        }
    }
    
    @IBInspectable var selectedTitleColor: UIColor? {
        get {
            return nil
        }
        set {
            if let newValue = newValue {
                setTitleColor(newValue, for: .selected)
            }
        }
    }
    
    @IBInspectable var highlightedBackgroundColor: UIColor? {
        get {
            return nil
        }
        set {
            if let newValue = newValue {
                setBackgroundColor(newValue, forState: .highlighted)
            }
        }
    }
    
    @IBInspectable var disabledBackgroundColor: UIColor? {
        get {
            return nil
        }
        set {
            if let newValue = newValue {
                setBackgroundColor(newValue, forState: .disabled)
            }
        }
    }
}

extension UIButton {
    /// 更新底部主题按钮的状态
    ///
    /// - Parameters:
    ///   - textFields: textField的数组
    ///   - types: InputTextType
    func updateEnabled(textFields: [UITextField], types: [InputTextType]) {
        var isEnabled = true
        for (index, textField) in textFields.enumerated() {
            if (textField.text ?? "").count < types[index].minCount {
                isEnabled = false
                break
            }
        }
        isUserInteractionEnabled = isEnabled
        isSelected = isEnabled
    }
}




