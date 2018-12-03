//
//  XCInformationQRCodeController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/15.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 我的二维码
class XCInformationQRCodeController: BaseViewController {

    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var codeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBarBackgroundColor(UIColor.blackGray)
        view.backgroundColor = UIColor.blackGray
        setStatusBarStyle(.lightContent)
        initView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setStatusBarStyle(.default)
    }
    
}

extension XCInformationQRCodeController {
    private func initView() {
        
        whiteView.layer.cornerRadius = 3
        whiteView.layer.masksToBounds = true
        
        avatarImageView.layer.cornerRadius = 3
        avatarImageView.layer.masksToBounds = true
        
        let model = ShareModel()
        codeImageView.image = model.url.qrCodeWithLogoImage(logoImage: model.logo)
        codeImageView.isUserInteractionEnabled = true
        codeImageView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(saveImage)))
    }
}

extension XCInformationQRCodeController {
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func moreAction(_ sender: UIBarButtonItem) {
        let alertCtrl = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertCtrl.addAction(UIAlertAction(title: "保存图片", style: .default, handler: { (action) in
            UIImageWriteToSavedPhotosAlbum(self.codeImageView.image!, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
        }))
        alertCtrl.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
            
        }))
        present(alertCtrl, animated: true, completion: nil)
    }
    
    ///  保存图片
    @objc func saveImage() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "保存二维码", style: .default, handler: { (action) in
            UIImageWriteToSavedPhotosAlbum(self.codeImageView.image!, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject) {
        if didFinishSavingWithError == nil {
            MBProgressHUD.show(info: "已保存到相册")
        }  else {
            MBProgressHUD.show(info: "二维码保存失败")
        }
    }
}
