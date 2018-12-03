//
//  XCCircleController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/8.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 朋友圈
class XCCircleController: BaseTableViewController {
    
    private var image = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        naviBackgroundAlpha = 0
        tableView.register(R.nib.xcCircleCell)
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setStatusBarStyle(.lightContent)
    }
    
    private var naviBackgroundAlpha: CGFloat = 0 {
        didSet {
            wr_setNavBarBackgroundAlpha(naviBackgroundAlpha)
            if naviBackgroundAlpha == 0 {
                setNaviBarTintColor(UIColor.white)
               setNaviBarShadowImage(isHidden: true)
                setStatusBarStyle(.lightContent)
            } else {
                setNaviBarTintColor(UIColor.navigationBarDefault.tint)
                setNaviBarShadowImage(isHidden: false)
                setStatusBarStyle(.default)
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        let changeHeight = (tableView.tableHeaderView?.frame.height ?? 200) - kNavigationHeight * 2 + kStatusBarHeight
        if y <= changeHeight {
            naviBackgroundAlpha = 0
        } else if y > changeHeight && y < changeHeight + kNavigationHeight {
            naviBackgroundAlpha = (y - changeHeight) / kNavigationHeight
        } else {
            naviBackgroundAlpha = 1
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.xcCircleCell, for: indexPath)!

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }

}
