//
//  XCInformationAreaController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/28.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

enum AreaType {
    /// 省
    case province
    /// 市
    case city
    /// 区/县
    case area
    
    var name: String {
        switch self {
        case .province: return "provinceName"
        case .city: return "cityName"
        case .area: return "areaName"
        }
    }
    
    var key: String {
        switch self {
        case .province: return ""
        case .city: return "citylist"
        case .area: return "arealist"
        }
    }
}

/// 修改地区
class XCInformationAreaController: UIViewController {

    @IBOutlet weak var backgroundViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var provinceButton: UIButton!
    @IBOutlet weak var cityButton: UIButton!
    
    @IBOutlet weak var provinceLineView: UIView!
    @IBOutlet weak var cityLineView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    private let viewTopConstraint = kScreenHeight * 1 / 3
    
    private let plist = NSArray(contentsOfFile: Bundle.main.path(forResource: "Area", ofType: "plist")!)!
    
    private var dataSource = NSArray()
    
    private var provinceSelectedRow = 0
    private var citySelectedRow = 0
    
    private var provinceName = String()
    private var cityName = String()
    private var areaName = String()
    
    private var provinceID = String()
    private var cityID = String()
    private var areaID = String()
    
    private var areaType: AreaType = .province {
        didSet {
            switch areaType {
            case .province:
                dataSource = plist
            case .city:
                dataSource = (plist[provinceSelectedRow] as! NSDictionary)[AreaType.city.key] as! NSArray
            case .area:
                dataSource = (((plist[provinceSelectedRow] as! NSDictionary)[AreaType.city.key] as! NSArray)[citySelectedRow] as! NSDictionary)[AreaType.area.key] as! NSArray
            }
            tableView.reloadData()
        }
    }
    
    public var editAreaSuceessBlock: ((_ province: String, _ provinceID: String, _ city: String, _ cityID: String, _ area: String, _ areaID: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.frame.origin.y = kScreenHeight
        dataSource = plist
        initTableView()
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundViewTopConstraint.constant = self.viewTopConstraint
            self.backgroundView.frame.origin.y = self.viewTopConstraint
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let allTouches = event?.allTouches
        let touch = allTouches?.first ?? UITouch()
        let point = touch.location(in: view)
        let y = point.y
        if y < backgroundView.frame.minY {
            dissmiss()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension XCInformationAreaController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = (dataSource[indexPath.row] as! NSDictionary)[areaType.name] as? String
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textColor = UIColor.darkGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch areaType {
        case .province:
            provinceSelectedRow = indexPath.row
            provinceID = (dataSource[indexPath.row] as! NSDictionary)["id"] as! String
            provinceName = (dataSource[indexPath.row] as! NSDictionary)[areaType.name] as! String
            provinceButton.setTitle(provinceName, for: .normal)
            changeSelectedState(index: 0)
            areaType = .city
        case .city:
            citySelectedRow = indexPath.row
            cityID = (dataSource[indexPath.row] as! NSDictionary)["id"] as! String
            cityName = (dataSource[indexPath.row] as! NSDictionary)[areaType.name] as! String
            cityButton.setTitle(cityName, for: .normal)
            changeSelectedState(index: 1)
            areaType = .area
        case .area:
            areaID = (dataSource[indexPath.row] as! NSDictionary)["id"] as! String
            areaName = (dataSource[indexPath.row] as! NSDictionary)[areaType.name] as! String
            editAreaSuceessBlock!(provinceName, provinceID, cityName, cityID, areaName, areaID)
            dissmiss()
        }
    }
    
}

extension XCInformationAreaController {
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
    private func initButton(sender: UIButton) {
        
    }
    
    @IBAction func provinceAction(_ sender: UIButton) {
        changeSelectedState(index: 0)
        areaType = .province
    }
    
    @IBAction func cityAction(_ sender: UIButton) {
        changeSelectedState(index: 1)
        areaType = .city
    }

    private func changeSelectedState(index: Int) {
        let buttons = [provinceButton, cityButton]
        let views = [provinceLineView, cityLineView]
        for (i, button) in buttons.enumerated() {
            if i <= index {
                button?.setTitleColor(UIColor.button.normal, for: .normal)
                button?.isHidden = false
                views[i]?.isHidden = false
            } else {
                button?.isHidden = true
                views[i]?.isHidden = true
            }
        }
    }
    
    private func dissmiss() {
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.frame.origin.y = kScreenHeight
            self.view.alpha = 0
        }) { (finish) in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
}
