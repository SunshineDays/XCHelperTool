//
//  XCBankCardAddController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/29.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 添加银行卡
class XCBankCardAddController: BaseTableViewController {

    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var cardNumberTextField: BankCardTextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    private var cardName = "xx银行"
    
    private var bankCardType: BankCardtype = .credit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardNumberTextField.customDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension XCBankCardAddController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kFooterInSectionHeight
    }

}

extension XCBankCardAddController: CustomTextFieldDelegate {
    func customTextFieldEditValueChanged(_ textField: UITextField) {
        nextButton.updateEnabled(textFields: [cardNumberTextField], types: [.bankCard])
    }
}

extension XCBankCardAddController {
    
    @IBAction func helpAction(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func showAction(_ sender: UIButton) {
        let alertCtrl = UIAlertController(title: "持卡人说明", message: "为保证账户资金安全，只能绑定认证用户本人的银行卡", preferredStyle: .alert)
        alertCtrl.addAction(UIAlertAction(title: "知道了", style: .cancel, handler: nil))
        present(alertCtrl, animated: true, completion: nil)
    }

    @IBAction func nextAction(_ sender: UIButton) {
        if bankCardType == .credit {
            let vc = R.storyboard.xcBankCard.xcBankCardInfoCreditController()!
            vc.initWith(fullName: fullNameLabel.text!, cardNumber: cardNumberTextField.text!, cardName: cardName)
            navigationController?.pushViewController(vc, animated: true)
        }
        if bankCardType == .debit {
            let vc = R.storyboard.xcBankCard.xcBankCardInfoDeibtController()!
            vc.initWith(fullName: fullNameLabel.text!, cardNumber: cardNumberTextField.text!, cardName: cardName)
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
