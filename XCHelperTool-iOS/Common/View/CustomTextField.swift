//
//  CustomTextField.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/28.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

protocol CustomTextFieldDelegate: class {
    func customTextFieldEditValueChanged(_ textField: UITextField)
}

class CustomTextField: UITextField, UITextFieldDelegate {
    /// 记录输入的长度
    public var lastCount = 0
    
    public weak var customDelegate: CustomTextFieldDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// 手机号码格式
class MobileTextField: CustomTextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        addTarget(self, action: #selector(editValueChanged(_:)), for: .editingChanged)
    }
    
    @objc private func editValueChanged(_ textField: UITextField) {
        lastCount = mobile(last: lastCount)
        customDelegate?.customTextFieldEditValueChanged(textField)
    }
    
    private func mobile(last count: Int) -> Int {
        let text = self.text ?? ""
        if text.count > count {
            if text.count == 4 || text.count == 9 {
                self.text = text.substring(to: text.count - 1) + " " + text.substring(from: text.count - 1)
            }
            if text.count >= 13 {
                self.text = self.text!.substring(to: 13)
            }
        } else if text.count < count {
            if text.count == 4 || text.count == 9 {
                self.text = text.substring(to: text.count - 1)
            }
        }
        return (self.text ?? "").count
    }
}

/// 银行卡号
class BankCardTextField: CustomTextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        addTarget(self, action: #selector(editValueChanged(_:)), for: .editingChanged)
    }
    
    @objc private func editValueChanged(_ textField: UITextField) {
        lastCount = bankCard(last: lastCount)
        customDelegate?.customTextFieldEditValueChanged(textField)
    }
    
    private func bankCard(last count: Int) -> Int {
        let text = self.text ?? ""
        if text.count > count {
            if text.count < 24 {
                if text.count % 5 == 0 {
                    self.text = text.substring(to: text.count - 1) + " " + text.substring(from: text.count - 1)
                }
            } else {
                self.text = self.text!.substring(to: 24)
            }
        } else {
            if text.count > 0 && text.count % 5 == 0 {
                self.text = text.substring(to: text.count - 1)
            }
        }
        return (self.text ?? "").count
    }
}

/// 身份证号码
class IDCardTextField: CustomTextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        addTarget(self, action: #selector(editValueChanged(_:)), for: .editingChanged)
    }
    
    @objc private func editValueChanged(_ textField: UITextField) {
        lastCount = idCard(last: lastCount)
        customDelegate?.customTextFieldEditValueChanged(textField)
    }
    
    private func idCard(last count: Int) -> Int {
        let text = self.text ?? ""
        if text.count > count {
            if text.count == 7 || text.count == 12 || text.count == 17 {
                self.text = text.substring(to: text.count - 1) + " " + text.substring(from: text.count - 1)
            }
            if text.count > 21 {
                self.text = self.text!.substring(to: 21)
            }
        } else {
            if text.count == 7 || text.count == 12 || text.count == 17 {
                self.text = text.substring(to: text.count - 1)
            }
        }
        return (self.text ?? "").count
    }
}

/// 限制文本长度
class MaxCountTextField: CustomTextField {
    public var maxCountType: InputTextType = .none
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTarget(self, action: #selector(editValueChanged(_:)), for: .editingChanged)
    }

    @objc func editValueChanged(_ textField: UITextField) {
        maxCount(max: maxCountType.maxCount)
        customDelegate?.customTextFieldEditValueChanged(textField)
    }
    
    private func maxCount(max count: Int = 30) {
        if (text ?? "").count > count {
            text = text?.substring(to: count)
        }
    }
}

/// 自定义UITextField(光标向右偏移15)
class LeftViewTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        borderStyle = .none
        layer.cornerRadius = 0
        layer.borderWidth = 1.pixel
        layer.borderColor = UIColor.line.cgColor
        font = UIFont.systemFont(ofSize: 18)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        leftViewMode = .always
    }
}
