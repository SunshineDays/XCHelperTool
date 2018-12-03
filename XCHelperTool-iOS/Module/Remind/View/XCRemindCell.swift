//
//  XCRemindCell.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/2.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

protocol XCRemindCellDelegate: class {
    func remindCell(_ cell: XCRemindCell, clickButton sender: UIButton, indexPath: IndexPath)
}

/// 提醒事件
class XCRemindCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var openButton: UIButton!
    
    private var indexPath = IndexPath()
    
    public weak var delegate: XCRemindCellDelegate?
    
    public func configCell(model: XCRemind, indexPath: IndexPath) {
        titleLabel.text = model.content
        timeLabel.text = model.time.timeString()
        openButton.isSelected = model.isOpen
        self.indexPath = indexPath
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        openButton.setImage(#imageLiteral(resourceName: "recommend_selected_fasle"), for: .normal)
        openButton.setImage(#imageLiteral(resourceName: "recommend_selected_true"), for: .selected)
    }

    @IBAction func openAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.remindCell(self, clickButton: sender, indexPath: indexPath)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
