//
//  XCSlider1Controller.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/10.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

class XCSlider1Controller: XCSlideController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        config(tableViewCellType: .slide2, tableViewModels: ["", "", "", "", "", "", "", "", ""], headerTableViewModels: ["", "", "", "", "", "", "", "", "", ""])
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
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
