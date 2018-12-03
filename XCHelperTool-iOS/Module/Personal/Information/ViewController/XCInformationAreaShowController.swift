//
//  XCInformationAreaShowController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/29.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

class XCInformationAreaShowController: BaseTableViewController {

    @IBOutlet weak var addressLabel: CustomContentLabel!
    
    @IBOutlet weak var adressDetailLabel: CustomContentLabel!
    
    public var editAreaSuceessBlock: ((_ address: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeaderInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kFooterInSectionHeight
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let vc = R.storyboard.xcInformation.xcInformationAreaController()!
            vc.editAreaSuceessBlock = { provinceName, provinceID, cityName, cityID, areaName, areaID in
                self.showCity(province: provinceName, provinceID: provinceID, city: cityName, cityID: cityID, area: areaName, areaID: areaID)
            }
            UIApplication.shared.keyWindow?.rootViewController?.addChild(vc)
            UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(vc.view)
        case (0, 1):
            let vc = R.storyboard.xcInformation.xcInformationInputInforController()!
            vc.initWith(inputInfoType: .address, info: adressDetailLabel.text) { (addressDetail) in
                self.adressDetailLabel.text = addressDetail
            }
            let navi = BaseNavigationController(rootViewController: vc)
            present(navi, animated: true, completion: nil)
        default:
            break
        }
    }
    
    private func showCity(province: String, provinceID: String, city: String, cityID: String, area: String, areaID: String) {
        var address = ""
        if city == "市辖区" || city == "县" {
            address = province + " " + area
        } else {
            address = province + " " + city
        }
        address = address.replacingOccurrences(of: "自治区", with: "")
        address = address.replacingOccurrences(of: "省", with: "")
        address = address.replacingOccurrences(of: "市", with: "")
        
        addressLabel.text = address
        
        editAreaSuceessBlock!(addressLabel.text ?? "")

    }
    

}
