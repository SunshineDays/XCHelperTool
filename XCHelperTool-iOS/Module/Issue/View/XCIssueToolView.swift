//
//  XCIssueToolView.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/11.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

protocol XCIssueToolViewDelegate: class {
    
    func issueToolView(_ toolView: XCIssueToolView, didClickLoactionButton sender: UIButton)

    func issueToolView(_ toolView: XCIssueToolView, didClickCameraButton sender: UIButton)
    
    func issueToolView(_ toolView: XCIssueToolView, didClickPhotoButton sender: UIButton)

    func issueToolView(_ toolView: XCIssueToolView, didClickEmjonButton sender: UIButton)

    func issueToolView(_ toolView: XCIssueToolView, didClickMoreButton sender: UIButton)

}

/// 发布 底部工具视图
class XCIssueToolView: UIView {
    
    public weak var delegate: XCIssueToolViewDelegate?
    
    @IBOutlet weak var locationButton: UIButton!
    
    @IBAction func loactionAction(_ sender: UIButton) {
        
    }
    
    @IBAction func cameraAction(_ sender: UIButton) {
        delegate?.issueToolView(self, didClickCameraButton: sender)
    }
    
    @IBAction func photoAction(_ sender: UIButton) {
        delegate?.issueToolView(self, didClickPhotoButton: sender)
    }
    
    @IBAction func emjonAction(_ sender: UIButton) {
        delegate?.issueToolView(self, didClickEmjonButton: sender)
    }
    
    @IBAction func moreAction(_ sender: UIButton) {
        delegate?.issueToolView(self, didClickMoreButton: sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        locationButton.layer.cornerRadius = locationButton.frame.height / 2
//        locationButton.layer.borderWidth = 1.pixel
//        locationButton.layer.borderColor = UIColor(hex: 0xE6E6E6).cgColor
//        locationButton.layer.masksToBounds = true
    }
}
