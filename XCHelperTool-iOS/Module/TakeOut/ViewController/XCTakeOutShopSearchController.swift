//
//  XCTakeOutShopSearchController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/27.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 商铺搜索
class XCTakeOutShopSearchController: BaseViewController {

    private lazy var titleView: XCTakeOutSearchTitleView = {
        let view = R.nib.xcTakeOutSearchTitleView.firstView(owner: nil)!
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleView)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
