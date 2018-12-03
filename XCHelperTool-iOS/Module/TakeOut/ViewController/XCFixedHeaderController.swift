//
//  XCFixedHeaderController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/29.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

class XCFixedHeaderController: BaseViewController {

    private let tableHeaderView = TableViewFixedHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
    
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension XCFixedHeaderController {
    private func initTableView() {
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.tableHeaderView = tableHeaderView
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}

extension XCFixedHeaderController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = indexPath.row.string
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableHeaderView.contentOffsetY = scrollView.contentOffset.y + kNavigationHeight
    }
    
    /// 结束拖动时调用
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        /// 不是减速(拖动结束后就不滚动了)
        if !decelerate {
            scrollViewDidEndScroll(scrollView)
        }
    }
    
    /// 结束减速的时候调用
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScroll(scrollView)
    }
    
    private func scrollViewDidEndScroll(_ scrollView: UIScrollView) {
        MBProgressHUD.show(info: "111111111111")
    }
    
    
}
