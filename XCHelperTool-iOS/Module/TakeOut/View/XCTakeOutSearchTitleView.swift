//
//  XCTakeOutSearchTitleView.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/27.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

protocol XCTakeOutSearchTitleViewDelegate: class {
    func takeOutSearchTitleView(_ view: XCTakeOutSearchTitleView, backButtonClick sender: UIButton)
    func takeOutSearchTitleView(_ view: XCTakeOutSearchTitleView, searchButtonClick sender: UIButton)
}

/// 搜索头部View
class XCTakeOutSearchTitleView: UIView {

    @IBOutlet weak var backButtonTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    public weak var delegate: XCTakeOutSearchTitleViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kNavigationHeight)
        backButtonTopConstraint.constant = kStatusBarHeight
        searchBar.delegate = self
        searchBar.backgroundColor(UIColor(hex: 0xF2F2F2))
        searchBar.layer.cornerRadius = 3
        searchBar.becomeFirstResponder()
    }
}

extension XCTakeOutSearchTitleView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
}

extension XCTakeOutSearchTitleView {
    @IBAction func backButtonAction(_ sender: UIButton) {
        delegate?.takeOutSearchTitleView(self, backButtonClick: sender)
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        delegate?.takeOutSearchTitleView(self, searchButtonClick: sender)
    }
    
}
