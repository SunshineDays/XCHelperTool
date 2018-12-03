//
//  XCHomeProgressController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/11/9.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

class XCHomeProgressController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)
        let bundle = Bundle(for: TimelineTableViewCell.self)
        let nibUrl = bundle.url(forResource: "TimelineTableViewCell", withExtension: "bundle")
        let timelineTabelViewCellNib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle(url: nibUrl!)!)
        tableView.register(timelineTabelViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        return tableView
    }()
    
}

extension XCHomeProgressController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as! TimelineTableViewCell
        return cell
    }
}
