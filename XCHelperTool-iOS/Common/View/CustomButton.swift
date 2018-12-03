//
//  CustomButton.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/28.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 主题按钮(不可交互)
class ThemeNormalButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleColor(UIColor.white, for: .normal)
        setBackgroundImage(UIColor.button.normal.convertToImage(), for: .normal)
        setBackgroundImage(UIColor.button.selected.convertToImage(), for: .selected)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        layer.cornerRadius = 4
        layer.masksToBounds = true
        tintColor = UIColor.clear
        isUserInteractionEnabled = false
        self.isSelected = false
    }
}

/// 主题按钮(可交互)
class ThemeSelectedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleColor(UIColor.white, for: .normal)
        setBackgroundImage(UIColor.button.normal.convertToImage(), for: .normal)
        setBackgroundImage(UIColor.button.selected.convertToImage(), for: .selected)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        layer.cornerRadius = 4
        layer.masksToBounds = true
        tintColor = UIColor.clear
        isUserInteractionEnabled = true
        self.isSelected = true
    }
}

/// 获取验证码按钮
class AuthCodeButton: UIButton {
    public var isTimerFire = false {
        willSet {
            if newValue {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                codeTimeInterval = kAuthCodeTimeInterval
            } else {
                timer?.invalidate()
                timer = nil
            }
            isUserInteractionEnabled = !newValue
        }
    }
    
    private var codeTimeInterval = 0 {
        willSet {
            if newValue > 0 {
                setTitle("\(newValue)s后重新获取", for: .normal)
            } else {
                setTitle("重新获取验证码", for: .normal)
                isTimerFire = false
            }
        }
    }
    
    private var timer: Timer?
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setTitle("获取验证码", for: .normal)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    @objc private func updateTime() {
        codeTimeInterval -= 1
    }
}


