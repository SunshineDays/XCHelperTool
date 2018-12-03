//
//  CustomTextView.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/7.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 带有占位符的TextView
class CustomTextView: UITextView, UITextViewDelegate {
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(placeholder)
        delegate = self
    }
    
    public lazy var placeholder: UILabel = {
        let label = UILabel(frame: CGRect(x: 7, y: 10, width: self.frame.width - 20, height: 15))
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    func textViewDidChange(_ textView: UITextView) {
        placeholder.isHidden = textView.text.count > 0
    }
}

