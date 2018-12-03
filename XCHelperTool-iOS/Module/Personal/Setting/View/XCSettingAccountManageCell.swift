//
//  XCSettingAccountManageCell.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/11.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

class XCSettingAccountManageCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = 27
        avatarImageView.layer.masksToBounds = true
//        avatarImageView.kf.setImage(with: URL(string: "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3339124938,20437337&fm=11&gp=0.jpg"))
//        avatarImageView.kf.setImage(with: URL(string: "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3339124938,20437337&fm=11&gp=0.jpg"), placeholder: #imageLiteral(resourceName: "tool_more"))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
