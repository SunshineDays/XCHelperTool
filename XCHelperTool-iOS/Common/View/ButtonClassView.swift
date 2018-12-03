
//
//  ButtonClassView.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/31.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

protocol ButtonClassViewDelegate: class {
    func buttonClassView(_ view: ButtonClassView, itemButtonClick sender: UIButton, selectedItemRow: Int)
}

/// button集合view
class ButtonClassView: UIView {
    
    public var titles = [String]() {
        didSet {
            initButtons()
        }
    }
    
    public weak var delegate: ButtonClassViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initButtons() {
        let leftSpacing: CGFloat = 15 // 左右间距
        let buttonSpacing: CGFloat = 10 // 按钮之间的间距
        let lineSpacing: CGFloat = 10 // 行间距
        let height: CGFloat = 30 // 按钮高度
        var x = leftSpacing
        var y = lineSpacing
        var row = 1
        
        for (index, title) in titles.enumerated() {
            let button = UIButton()
            button.backgroundColor = UIColor.orange
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            
            let width = (button.titleLabel?.textWidth ?? 10) + 10
            
            if x + width > frame.width - leftSpacing {
                x = leftSpacing
                y = y + height + lineSpacing
                row = row + 1
            }
            
            button.frame = CGRect(x: x, y: y, width: width, height: height)
            button.layer.cornerRadius = 6
            button.tag = index
            button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            addSubview(button)
            
            x = x + width + buttonSpacing
        }
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: (lineSpacing +  height) * CGFloat(row) + lineSpacing)
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        delegate?.buttonClassView(self, itemButtonClick: sender, selectedItemRow: sender.tag)
    }
}
