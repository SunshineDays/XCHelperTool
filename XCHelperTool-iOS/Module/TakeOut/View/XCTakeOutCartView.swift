//
//  XCTakeOutSelectedView.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/9/4.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

protocol XCTakeOutCartViewDelegate: class {
     func takeOutCartView(_ view: XCTakeOutCartView, didFinishedChangNumber number: Int, indexPath: IndexPath)
}

class XCTakeOutCartView: UIView {
    
    @IBOutlet weak var contentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalWeightLabel: UILabel!
    
    private var controller = UIViewController()
    
    private let darkButton = UIButton(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kNavigationHeight))
    
    public weak var delegate: XCTakeOutCartViewDelegate?
    
    /// 弹窗配置
    ///
    /// - Parameters:
    ///   - view: self.view
    ///   - amountView: 底部的总计view(当为nil时，不显示弹窗)
    ///   - controller: self
    public func configView(view: UIView, amountView: UIView?, controller: UIViewController) {
        self.controller = controller
        frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 50 - kBottomMargin)
        
        if let _ = superview {
            dismissView()
        } else {
            if let amountView = amountView {
                /// 显示的时候暂时关闭右滑返回
                view.addSubview(self)
                view.bringSubviewToFront(amountView)
                controller.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                self.alpha = 1
                self.contentView.frame.origin.y = frame.height
                initDarkView()
                darkButton.isHidden = false
                initTableView()
                initAnimate()
            } else {
                dismissView()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        initDarkView()
        darkButton.addTarget(self, action: #selector(dismissAction(_:)), for: .touchUpInside)
    }
    
    private var count = 20

}

extension XCTakeOutCartView {

    private func initTableView() {
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(R.nib.xcTakeOutCartCell)
        tableView.reloadData()
    }
    
    private func initDarkView() {
        darkButton.backgroundColor = UIColor(hex: 0x000000, alpha: 0.4)
        UIApplication.shared.keyWindow?.addSubview(darkButton)
        darkButton.isHidden = true
        darkButton.alpha = 1
    }
    
    private func initAnimate() {
        UIView.animate(withDuration: 0.3) {
//            self.contentViewTopConstraint.constant = 150
            self.contentView.frame.origin.y = 150
        }
    }
}

extension XCTakeOutCartView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.xcTakeOutCartCell, for: indexPath)!
        cell.configCell { (number) in
            self.delegate?.takeOutCartView(self, didFinishedChangNumber: number, indexPath: indexPath)
            if number == 0 {
                self.count -= 1
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension XCTakeOutCartView {
    @IBAction func clearAction(_ sender: UIButton) {
        dismissView()
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
        dismissView()
    }
    
    private func dismissView() {
        controller.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
            self.darkButton.alpha = 0
//            self.contentViewTopConstraint.constant = kScreenHeight
            self.contentView.frame.origin.y = kScreenHeight - 100
        }) { (isFinished) in
            self.darkButton.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
}


