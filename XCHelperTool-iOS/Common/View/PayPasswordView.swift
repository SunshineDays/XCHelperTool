//
//  PayPasswordView.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/31.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 支付密码输入框
class PayPasswordView: UIView {
    typealias PayPasswordViewBlock = (_ textField: UITextField) -> Void
    private var payPasswordBlock: PayPasswordViewBlock?
    
    private var lineColor = UIColor.button.selected
    private var textFieldHeight: CGFloat = 45
    
    /// 存放黑点
    private var dots = [UIView]()
    
    public func initWith(lineColor: UIColor, height: CGFloat = 45, payPasswordBlock: @escaping PayPasswordViewBlock) {
        self.lineColor = lineColor
        textFieldHeight = height
        self.payPasswordBlock = payPasswordBlock
        addSubview(passwordTextField)
        initPasswordContentView()
    }
    
    public lazy var passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: kScreenWidth - frame.origin.x * 2, height: textFieldHeight))
        textField.keyboardType = .numberPad
        textField.textColor = UIColor.clear
        textField.autocapitalizationType = .none
        textField.becomeFirstResponder()
        textField.layer.borderWidth = 1.pixel
        textField.layer.borderColor = lineColor.cgColor
        textField.layer.cornerRadius = 6
        textField.layer.masksToBounds = true
        textField.tintColor = UIColor.clear
        textField.addTarget(self, action: #selector(editChangeValue(_:)), for: .editingChanged)
        return textField
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension PayPasswordView {
    private func initPasswordContentView() {
        let lineWidth: CGFloat = 1.pixel
        let dotWidth : CGFloat = 11
        let spaceWidth = (passwordTextField.frame.width - lineWidth * 5) / 6
        //分割线
        for i in 1 ..< 6 {
            let lineView = UIView(frame: CGRect(x: spaceWidth * CGFloat(i), y: passwordTextField.frame.minY, width: lineWidth, height: passwordTextField.frame.height))
            lineView.backgroundColor = lineColor
            addSubview(lineView)
        }
        //黑点
        for i in 0 ..< 6 {
            let dotView = UIView(frame: CGRect(x: (spaceWidth + lineWidth) * CGFloat(i) + spaceWidth / 2 - dotWidth / 2, y: passwordTextField.center.y - dotWidth / 2, width: dotWidth, height: dotWidth))
            dotView.backgroundColor = UIColor.black
            dotView.layer.cornerRadius = dotWidth / 2
            dotView.isHidden = true
            dotView.clipsToBounds = true
            addSubview(dotView)
            dots.append(dotView)
        }
    }
    
    @objc private func editChangeValue(_ textField: UITextField) {
        if textField.text?.count ?? 0 <= 6 {
            for (index, view) in dots.enumerated() {
                view.isHidden = index >= (passwordTextField.text ?? "").count
            }
            payPasswordBlock?(textField)
        } else {
            textField.text = textField.text?.substring(to: 6)
        }
    }
}
