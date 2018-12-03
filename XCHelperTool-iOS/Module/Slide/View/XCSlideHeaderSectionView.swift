//
//  XCSlideHeaderSectionView.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/10.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

protocol XCSlideHeaderSectionViewDelegate: class {
    func slideHeaderSectionView(_ view: XCSlideHeaderSectionView, clickShowButton sender : UIButton)
}

class XCSlideHeaderSectionView: UIView {

    @IBOutlet weak var issueLabel: UILabel!
    
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var showButton: UIButton!
    
    public weak var delegate: XCSlideHeaderSectionViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 35)
        showButton.setImage(R.image.tool_down(), for: .normal)
        showButton.setImage(R.image.tool_up(), for: .selected)
    }
    
    @IBAction func showAction(_ sender: UIButton) {
        showButton.isSelected = !showButton.isSelected
        delegate?.slideHeaderSectionView(self, clickShowButton: showButton)
    }
    
}
