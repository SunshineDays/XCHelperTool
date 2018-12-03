//
//  UITableViewExt.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/19.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// 结束刷新（数据请求成功）
    ///
    /// - Parameters:
    ///   - dataSource: tableView数据源
    ///   - pageInfo: PageInfoModel
    func endRefreshing(dataSource: [Any]?, pageInfo: PageInfoModel) {
        mj_header.endRefreshing()
        if dataSource?.isEmpty ?? true || dataSource?.count == pageInfo.dataCount {
            mj_footer.isHidden = true
            mj_footer.endRefreshingWithNoMoreData()
        } else {
            mj_footer.isHidden = false
            mj_footer.endRefreshing()
        }
    }
    
    /// 结束刷新（数据请求失败）
    func endRefreshing() {
        mj_header.endRefreshing()
        mj_footer.endRefreshing()
    }
}

/// 每页默认个数
let kPageInfoModelDefaultPageSize = 20

/// 分页信息
struct PageInfoModel: BaseModelProtocol {
    
    var json: JSON
    
    /// 当前页
    var page: Int = 1
    
    /// 每页个数
    var pageSize: Int = kPageInfoModelDefaultPageSize
    
    /// 总页数
    var pageCount: Int = 0
    
    /// 数据总数
    var dataCount: Int = 0
    
    init(page: Int, pageSize:Int = kPageInfoModelDefaultPageSize) {
        self.page = page
        self.pageSize = pageSize
        self.json = JSON(NSNull())
    }
    
    init(json: JSON) {
        self.json      = json
        self.page      = json["page"].intValue
        self.pageSize  = json["pagesize"].intValue
        self.pageCount = json["pagecount"].intValue
        self.dataCount = json["datacount"].intValue
    }
}
