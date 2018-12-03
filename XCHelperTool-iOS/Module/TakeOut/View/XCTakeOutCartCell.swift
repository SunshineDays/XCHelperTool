//
//  XCTakeOutCartCell.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/9/5.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

class XCTakeOutCartCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var minusButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    private var number = 2
    
    typealias ChangeNumberBlock = (_ number: Int) -> Void
    
    private var changeNumberBlock: ChangeNumberBlock!
    
    public func configCell(changeNumberBlock: @escaping ChangeNumberBlock) {
        self.changeNumberBlock = changeNumberBlock
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension XCTakeOutCartCell {
    private func initView() {
        minusButton.layer.cornerRadius = minusButton.frame.width / 2
        minusButton.layer.borderWidth = 1
        minusButton.layer.borderColor = UIColor.line.cgColor
        addButton.layer.cornerRadius = addButton.frame.width / 2
        numberLabel.text = number.string
    }
}

extension XCTakeOutCartCell {
    @IBAction func minusAction(_ sender: UIButton) {
        if number > 0 {
            number -= 1
        }
        numberLabel.text = number.string
        changeNumberBlock(number)
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        if number < 99 {
            number += 1
        }
        numberLabel.text = number.string
        changeNumberBlock(number)
    }
    
}

