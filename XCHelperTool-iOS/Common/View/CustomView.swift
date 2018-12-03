//
//  CustomView.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/6.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 透明的View
class ClearView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
    }
}

/// 主题颜色的View
class ThemeView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        frame = CGRect(x: 0, y: -UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        backgroundColor = UIColor.theme
    }
}

/// 加载失败提示view
class LoadFailedView: UIView {
    typealias GetDataAgainBlock = () -> Void
    public var getDataAgainBlock: GetDataAgainBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        titleLabel.attributedText = EmptyRequestType.error.title
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(getDataAgain(_:)), for: .touchUpInside)
        addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func getDataAgain(_ sender: UIButton) {
        if let block = getDataAgainBlock {
            block()
        }
    }
}

class ProgressView: UIView {
    
    
    public func configView(centerGaps: [CGFloat], defaultColor: UIColor = UIColor.gray, selectedColor: UIColor, selectedIndex: Int, lineTickness: CGFloat = 3) {
        self.centerGaps = centerGaps
        self.lineDfaultColor = defaultColor
        self.lineSelectedColor = selectedColor
        self.selectedIndex = selectedIndex
        self.lineThickness = lineTickness
        initLineView()
    }
    
    /// 中心间隔
    private var centerGaps = [CGFloat]()
    /// 选中了哪一个
    private var selectedIndex = 0
    /// 线的厚度
    private var lineThickness: CGFloat = 3
    /// 选中的线的颜色
    private var lineSelectedColor = UIColor.blue
    /// 默认线的颜色
    private var lineDfaultColor = UIColor.gray
    
    private var defaultIconImages = [R.image.share_logo()!, R.image.share_logo()!, R.image.share_logo()!, R.image.share_logo()!]
    
    private var selectedIconImages = [R.image.tool_setting()!, R.image.tool_setting()!, R.image.tool_setting()!, R.image.tool_setting()!]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        initLineView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLineView() {
        
        let backgroundLineView = UIView()
        backgroundLineView.backgroundColor = UIColor.gray
        addSubview(backgroundLineView)
        let selectedLineView = UIView()
        selectedLineView.backgroundColor = lineSelectedColor
        backgroundLineView.addSubview(selectedLineView)
        
//        var iconImageViews = [UIImageView]()
        
        var backgroundLineViewLength: CGFloat = 0
        var selectedScale: CGFloat = 0.0
        for (index, gap) in centerGaps.enumerated() {
            if frame.height > frame.width {
                var imageViewY: CGFloat = 0
                switch index {
                case 0:
                    imageViewY = 0
                case centerGaps.count - 1:
                    imageViewY = backgroundLineViewLength + gap - frame.width
                default:
                    imageViewY = backgroundLineViewLength - frame.width / 2
                }
                let iconImageView = UIImageView(frame: CGRect(x: 0, y: imageViewY, width: frame.width, height: frame.width))
                iconImageView.image = index <= selectedIndex ? selectedIconImages[index] : defaultIconImages[index]
                addSubview(iconImageView)
            } else {
                var imageViewX: CGFloat = 0
                switch index {
                case 0:
                    imageViewX = 0
                case centerGaps.count - 1:
                    imageViewX = backgroundLineViewLength - frame.width
                default:
                    imageViewX = backgroundLineViewLength - frame.width / 2
                }
                let iconImageView = UIImageView(frame: CGRect(x: imageViewX, y: 0, width: frame.width, height: frame.width))
                iconImageView.image = index <= selectedIndex ? selectedIconImages[index] : defaultIconImages[index]
                addSubview(iconImageView)
            }
            
            backgroundLineViewLength += gap

        }
        for (index, gap) in centerGaps.enumerated() {
            if index <= selectedIndex {
                selectedScale += gap / backgroundLineViewLength
            }
        }

        /// 竖直
        if frame.height > frame.width {
            backgroundLineView.frame = CGRect(x: (frame.width - lineThickness) / 2, y: 0, width: lineThickness, height: backgroundLineViewLength)
            selectedLineView.frame = CGRect(x: 0, y: 0, width: lineThickness, height: backgroundLineViewLength * selectedScale)
        } else {
            backgroundLineView.frame = CGRect(x: 0, y: (frame.height - lineThickness) / 2, width: backgroundLineViewLength, height: lineThickness)
            selectedLineView.frame = CGRect(x: 0, y: 0, width: backgroundLineViewLength * selectedScale, height: lineThickness)
        }
        
    }
    
}
