//
//  XCBankCardInfoDeibtController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/29.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 添加银行卡（储蓄卡）填写信息
class XCBankCardInfoDeibtController: BaseTableViewController {

    @IBOutlet weak var cardNameLabel: UILabel!
    
    @IBOutlet weak var phonetextField: MobileTextField!
    
    @IBOutlet weak var nextButton: ThemeNormalButton!
    
    private let bankCardType: BankCardtype = .credit
    
    private var fullName = String()
    
    private var cardName = String()
    
    private var cardNumber = String()
    
    public func initWith(fullName: String, cardNumber: String, cardName: String) {
        self.fullName = fullName
        self.cardName = cardName
        self.cardNumber = cardNumber
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardNameLabel.text = cardName
        phonetextField.customDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeaderInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kFooterInSectionHeight
    }

    @IBAction func nextAction(_ sender: ThemeNormalButton) {
        
    }
}

extension XCBankCardInfoDeibtController: CustomTextFieldDelegate {
    func customTextFieldEditValueChanged(_ textField: UITextField) {
        nextButton.updateEnabled(textFields: [textField], types: [.phone])
    }
}
