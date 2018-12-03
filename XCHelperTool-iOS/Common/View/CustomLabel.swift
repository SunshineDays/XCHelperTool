//
//  CustomLabel.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/28.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// TableViewCell Title Label
class CustomTitleLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        font = UIFont.systemFont(ofSize: 16)
        textColor = UIColor.black
    }
}

/// TableViewCell Content Label
class CustomContentLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        font = UIFont.systemFont(ofSize: 15)
        textColor = UIColor.darkGray
    }
}

