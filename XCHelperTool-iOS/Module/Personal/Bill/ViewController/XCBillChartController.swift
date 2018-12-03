//
//  XCBillChartController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/29.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 账单 图表
class XCBillChartController: BaseTableViewController, ChartViewDelegate {
    
    private lazy var pieChartView: XCBillChartConsumeView = {
        let view = XCBillChartConsumeView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth))
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView = pieChartView
        tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}
