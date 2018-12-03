//
//  XCSlideController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/9.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

class XCSlideController: BaseViewController {
    
    /// 子类必须实现的方法
    ///
    /// - Parameters:
    ///   - tableViewCellType: tableViewCell类型
    ///   - tableViewModels: 内容数组模型
    ///   - headerTableViewModels: 头部数组模型
    public func config(tableViewCellType: TableViewCellType, tableViewModels: [Any], headerTableViewModels: [Any]) {
        
        self.headerHeight = tableViewCellType.headerCellRowHeight * CGFloat(headerTableViewModels.count)
        
        self.tableViewModels = tableViewModels
        self.headerTableViewModels = headerTableViewModels
        self.tableViewCellType = tableViewCellType
        
        headerTableView.reloadData()
        tableView.reloadData()
        /// 延迟加载，避免tableView没有刷新完引起错乱
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            self.tableView.setContentOffset(CGPoint(x: 0, y: self.headerHeight), animated: false)
        }
    }
    
    private var tableViewModels = [Any]()
    
    private var headerTableViewModels = [Any]()
    
    private var tableViewCellType: TableViewCellType = .slide1

    /// 头部View高度
    private var headerHeight: CGFloat = kScreenWidth
    
    /// 滑动结束时的 contentOffset.y
    private var endContentOffsetY = kScreenWidth
    
    private var isDown: Bool = true
    
    private lazy var headerTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: headerHeight))
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(UINib(nibName: tableViewCellType.headerCellName, bundle: nil), forCellReuseIdentifier: tableViewCellType.headerCellName)
        return tableView
    }()
    
    private lazy var tableHeaderView: TableViewFixedHeaderView = {
        let view = TableViewFixedHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: headerHeight))
        view.contentView.addSubview(headerTableView)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: kNavigationHeight, width: kScreenWidth, height: kScreenHeight - kNavigationHeight))
        tableView.tableHeaderView = tableHeaderView
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: tableViewCellType.cellName, bundle: nil), forCellReuseIdentifier: tableViewCellType.cellName)
        tableView.register(UINib(nibName: tableViewCellType.footerCellName, bundle: nil), forCellReuseIdentifier: tableViewCellType.footerCellName)
        view.addSubview(tableView)
        return tableView
    }()
    
    private lazy var headerSectionView: XCSlideHeaderSectionView = {
        let view = R.nib.xcSlideHeaderSectionView.firstView(owner: nil)!
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config(tableViewCellType: .slide1, tableViewModels: ["", "", "", "", "", "", ""], headerTableViewModels: ["", "", "", "", ""])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension XCSlideController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == headerTableView ? headerTableViewModels.count : tableViewModels.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == headerTableView {
            switch tableViewCellType {
            case .slide1:
                let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellType.headerCellName, for: indexPath) as! XCSlide1HeaderCell
                return cell
            case .slide2:
                let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellType.headerCellName, for: indexPath) as! XCSlide1HeaderCell
                return cell
            }
        } else {
            if indexPath.row != tableViewModels.count {
                switch tableViewCellType {
                case .slide1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellType.cellName, for: indexPath) as! XCSlide1Cell
                    return cell
                case .slide2:
                    let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellType.cellName, for: indexPath) as! XCSlide2Cell
                    return cell
                }
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellType.footerCellName, for: indexPath) as! XCSlideFooterCell
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cell.frame.width)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == headerTableView {
            return tableViewCellType.headerCellRowHeight
        } else {
            if indexPath.row != tableViewModels.count {
                return tableViewCellType.cellRowHeight
            } else {
                var height = tableView.frame.height - CGFloat(tableViewModels.count) * tableViewCellType.cellRowHeight - headerSectionView.frame.height
                height = height >= 0 ? height : 0
                return height
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView == headerTableView ? nil: headerSectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView == headerTableView ? 0 : 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension XCSlideController: XCSlideHeaderSectionViewDelegate {
    func slideHeaderSectionView(_ view: XCSlideHeaderSectionView, clickShowButton sender: UIButton) {
        if sender.isSelected {
            tableView.setContentOffset(.zero, animated: true)
        } else {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}

extension XCSlideController {
    /// 滑动中
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        print(y)
        
        if scrollView == self.tableView {
            tableHeaderView.contentOffsetY = y
        }
        
        if y == 0 {
            headerSectionView.showButton.isSelected = true
        } else if y >= headerHeight {
            headerSectionView.showButton.isSelected = false
        }

        isDown = y <= endContentOffsetY
        endContentOffsetY = y
    }
    
    /// 结束拖动
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndScroll(scrollView)
        }
    }
    
    /// 开始减速
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScroll(scrollView)
    }
    
    private func scrollViewDidEndScroll(_ scrollView: UIScrollView) {
        if isDown {
            tableView.setContentOffset(.zero, animated: true)
        } else {
            if scrollView.contentOffset.y <= headerHeight {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
}
