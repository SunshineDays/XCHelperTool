//
//  XCThirdController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/5/31.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

class XCThirdController: BaseViewController {

    private let buttonsView = ButtonClassView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 200))
    
    private let authCodeButton = AuthCodeButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "3"
        
        buttonsView.backgroundColor = UIColor.white
        buttonsView.titles = ["哈哈", "哈哈哈哈啊哈", "哈哈", "哈哈哈", "哈哈", "哈哈哈哈啊哈", "哈啊哈哈哈", "哈哈哈", "哈哈哈哈", "哈哈哈哈啊哈", "哈哈", "哈哈哈"]
        buttonsView.delegate = self
        view.addSubview(buttonsView)
        
        authCodeButton.frame = CGRect(x: 50, y: 400, width: 100, height: 40)
        authCodeButton.addTarget(self, action: #selector(timeFire(_:)), for: .touchUpInside)
        authCodeButton.backgroundColor = UIColor.theme
        authCodeButton.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(authCodeButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        authCodeButton.isTimerFire = false
    }
    
    @objc private func timeFire(_ sender: UIButton) {
        authCodeButton.isTimerFire = true
    }

}

extension XCThirdController: ButtonClassViewDelegate {
    func buttonClassView(_ view: ButtonClassView, itemButtonClick sender: UIButton, selectedItemRow: Int) {
        MBProgressHUD.show(info: buttonsView.titles[selectedItemRow])
    }
}
