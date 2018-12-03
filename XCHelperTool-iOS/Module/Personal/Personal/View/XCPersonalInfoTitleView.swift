//
//  XCPersonalInfoTitleView.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/4.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 我的 个人信息 TitleView
class XCPersonalInfoTitleView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.layer.masksToBounds = true
    }
        
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var signLabel: UILabel!
    
    @IBOutlet weak var historyNumberLabel: UILabel!
    @IBOutlet weak var followerNumberLabel: UILabel!
    @IBOutlet weak var fansNumberLabel: UILabel!
    
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var fansButton: UIButton!

    
    public func configView() {
        
    }
    
}
