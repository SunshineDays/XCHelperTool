//
//  XCIssuePhotoCell.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/11.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 发布 图片 CollectionViewCell
class XCIssuePhotoCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 3
        layer.masksToBounds = true
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var deleteButton: UIButton!
    

}
