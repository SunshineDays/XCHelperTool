//
//  XCInformationController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/14.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 个人信息
class XCInformationController: BaseTableViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: CustomContentLabel!
    @IBOutlet weak var genderLabel: CustomContentLabel!
    @IBOutlet weak var certificationStateLabel: CustomContentLabel!
    @IBOutlet weak var addressLabel: CustomContentLabel!
    @IBOutlet weak var emailLabel: CustomContentLabel!
    
    private var avatarImage = UIImage()
    
    typealias EditAvatarSuccessBlock = (UIImage) -> Void
    
    private var editAvatarSuccessBlock: EditAvatarSuccessBlock!
    
    public func initWith(avatar: UIImage, avatarBlock: @escaping EditAvatarSuccessBlock) {
        avatarImage = avatar
        self.editAvatarSuccessBlock = avatarBlock
        
        
        // 43.48  25.64  28.57  97.70
        // 47.62  29.41  19.05  96.08
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImageView.image = avatarImage
        avatarImageView.layer.cornerRadius = 3
        avatarImageView.layer.masksToBounds = true
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeaderInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kFooterInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (0, 0): //头像
            let vc = R.storyboard.xcInformation.xcInformationAvatarController()!
            vc.initWith(avatar: avatarImageView.image ?? #imageLiteral(resourceName: "share_logo")) { (avatar) in
                self.avatarImageView.image = avatar
                self.editAvatarSuccessBlock(avatar)
            }
            navigationController?.pushViewController(vc, animated: true)
        case (1, 0): //昵称
            let vc = R.storyboard.xcInformation.xcInformationInputInforController()!
            vc.initWith(inputInfoType: .nickname, info: nicknameLabel.text) { (nickname) in
                self.nicknameLabel.text = nickname
            }
            let navi = BaseNavigationController(rootViewController: vc)
            present(navi, animated: true, completion: nil)
        case (1, 1): //性别
            editGender()
        case (2, 0): //实名认证
            let vc = R.storyboard.xcInformation.xcInformationCertificationController()!
            vc.initWith {
                self.certificationStateLabel.text = "已实名"
            }
            navigationController?.pushViewController(vc, animated: true)
        case (3, 0): //我的二维码
            let vc = R.storyboard.xcInformation.xcInformationQRCodeController()!
            let navi = BaseNavigationController(rootViewController: vc)
            present(navi, animated: true, completion: nil)
        case (3, 1): //地区
            let vc = R.storyboard.xcInformation.xcInformationAreaShowController()!
            vc.editAreaSuceessBlock = { address in
                self.addressLabel.text = address
            }
            navigationController?.pushViewController(vc, animated: true)
        case (3, 2): //邮箱
            let vc = R.storyboard.xcInformation.xcInformationInputInforController()!
            vc.initWith(inputInfoType: .email, info: emailLabel.text) { (email) in
                self.emailLabel.text = email
            }
            let navi = BaseNavigationController(rootViewController: vc)
            present(navi, animated: true, completion: nil)
        default:
            break
        }
    }
}

extension XCInformationController {
    
    private func editGender() {
        let alertCtrl = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let genders: [UserGenderType] = [.male, .female, .none]
        for gender in genders {
            alertCtrl.addAction(UIAlertAction(title: gender.name, style: .default, handler: { (action) in
                self.genderLabel.text = gender.name
            }))
        }
        alertCtrl.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
            
        }))
        present(alertCtrl, animated: true, completion: nil)
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
        
    }
    
}
