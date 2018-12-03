//
//  XCTakeOutAmountView.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/9/4.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

protocol XCTakeOutAmountViewDelegate: class {
    func takeOutAmountView(_ view: XCTakeOutAmountView, showSelectedShopButtonClick sender: UIButton)
    func takeOutAmountView(_ view: XCTakeOutAmountView, payButtonClick sender: UIButton)
}


class XCTakeOutAmountView: UIView {

    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var freightLabel: UILabel!
    private var isShow = false
    
    public weak var delegate: XCTakeOutAmountViewDelegate?
    
    @IBAction func payAction(_ sender: UIButton) {
        delegate?.takeOutAmountView(self, payButtonClick: sender)
    }
    
    @IBAction func showSelectedAction(_ sender: UIButton) {
        isShow = !isShow
        delegate?.takeOutAmountView(self, showSelectedShopButtonClick: sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
