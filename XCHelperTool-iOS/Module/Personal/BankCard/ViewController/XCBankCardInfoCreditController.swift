//
//  XCBankCardInfoCreditController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/29.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 添加银行卡（信用卡）填写信息
class XCBankCardInfoCreditController: BaseTableViewController {

    @IBOutlet weak var cardNameLabel: UILabel!
    
    @IBOutlet weak var expiryDataTextField: MaxCountTextField!
    
    @IBOutlet weak var phonetextField: MobileTextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
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
        expiryDataTextField.customDelegate = self
        expiryDataTextField.maxCountType = .expiryData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension XCBankCardInfoCreditController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 40 : kHeaderInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kFooterInSectionHeight
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension XCBankCardInfoCreditController: CustomTextFieldDelegate {
    func customTextFieldEditValueChanged(_ textField: UITextField) {
        nextButton.updateEnabled(textFields: [expiryDataTextField, phonetextField], types: [.expiryData, .phone])
    }
}

extension XCBankCardInfoCreditController {
    
    @IBAction func showAction(_ sender: UIButton) {
        let alertCtrl = UIAlertController(title: "有效期说明", message: "有效期打印在信用卡正面卡号下方", preferredStyle: .alert)
        alertCtrl.addAction(UIAlertAction(title: "知道了", style: .cancel, handler: nil))
        present(alertCtrl, animated: true, completion: nil)
    }
    
    @IBAction func nextAction(_ sender: UIButton) {

    }
    
}
