//
//  XCTakeOutController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/24.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 外卖
class XCTakeOutShopController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    private let amountView = R.nib.xcTakeOutAmountView.firstView(owner: nil)!
    private let cartView = R.nib.xcTakeOutCartView.firstView(owner: nil)!
    
    /// 是否将要隐藏导航栏
    private var isWillHiddenNavi = false
    
    private lazy var titleView: XCTakeOutShopSearchTitleView = {
        let view = R.nib.xcTakeOutShopSearchTitleView.firstView(owner: nil)!
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.button.selected
        view.addSubview(titleView)
        tableViewTopConstraint.constant = kNavigationHeight
        tableView.addSubview(ThemeView())
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        amountView.delegate = self
        view.addSubview(amountView)
        view.bringSubviewToFront(amountView)
        amountView.snp.makeConstraints { (maker) in
            maker.left.right.bottom.equalToSuperview()
            maker.height.equalTo(50 + kBottomMargin)
        }
        
        cartView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        isWillHiddenNavi = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if !isWillHiddenNavi {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension XCTakeOutShopController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        titleView.searchBarChangedX = scrollView.contentOffset.y
    }
}

extension XCTakeOutShopController: XCTakeOutShopSearchTitleViewDelegate {

    func takeOuteSearchTitleView(_ view: XCTakeOutShopSearchTitleView, backButtonClick sender: UIButton) {
        navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func takeOuteSearchTitleView(_ view: XCTakeOutShopSearchTitleView, searchButtonClick sender: UIButton) {
        goToSearchViewController()
    }
    
    func takeOuteSearchTitleView(_ view: XCTakeOutShopSearchTitleView, loveButtonClick sender: UIButton) {
        
    }
    
    func takeOuteSearchTitleView(_ view: XCTakeOutShopSearchTitleView, moreButtonClick sender: UIButton) {
        
    }
    
    func takeOuteSearchTitleView(_ view: XCTakeOutShopSearchTitleView, searchBarTextDidBeginEditing searchBar: UISearchBar) {
        goToSearchViewController()
    }
    
    private func goToSearchViewController() {
        isWillHiddenNavi = true
        let vc = XCTakeOutShopSearchController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension XCTakeOutShopController: XCTakeOutAmountViewDelegate {
    func takeOutAmountView(_ view: XCTakeOutAmountView, showSelectedShopButtonClick sender: UIButton) {
        cartView.configView(view: self.view, amountView: amountView, controller: self)
    }
    
    func takeOutAmountView(_ view: XCTakeOutAmountView, payButtonClick sender: UIButton) {
        cartView.configView(view: self.view, amountView: nil, controller: self)
        navigationController?.pushViewController(XCThirdController(), animated: true)
    }
    
}

extension XCTakeOutShopController: XCTakeOutCartViewDelegate {
    func takeOutCartView(_ view: XCTakeOutCartView, didFinishedChangNumber number: Int, indexPath: IndexPath) {
        
    }
}

