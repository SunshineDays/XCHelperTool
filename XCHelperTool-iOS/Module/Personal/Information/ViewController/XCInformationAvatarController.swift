//
//  XCInformationAvatarController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/14.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 个人头像
class XCInformationAvatarController: BaseViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    private var avatarImage = UIImage()
    
    typealias EditAvatarSuccessBlock = (UIImage) -> Void
    
    private var editAvatarSuccessBlock: EditAvatarSuccessBlock!
    
    public func initWith(avatar: UIImage, avatarBlock: @escaping EditAvatarSuccessBlock) {
        avatarImage = avatar
        self.editAvatarSuccessBlock = avatarBlock
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImageView.image = avatarImage
    }
}

extension XCInformationAvatarController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            if let image = picker.image(info: info) {
                self.avatarImageView.image = image
                self.editAvatarSuccessBlock(image)
            }
        }
    }
}

extension XCInformationAvatarController {
    
    @IBAction func moreAction(_ sender: UIBarButtonItem) {
        let imagePicCtrl = UIImagePickerController()
        imagePicCtrl.delegate = self
        imagePicCtrl.allowsEditing = true
        
        let alertCtrl = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertCtrl.addAction(UIAlertAction(title: "拍照", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicCtrl.sourceType = .camera
                imagePicCtrl.cameraDevice = .rear
                self.present(imagePicCtrl, animated: true, completion: nil)
            }
        }))
        alertCtrl.addAction(UIAlertAction(title: "从相册中选择", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                imagePicCtrl.sourceType = .photoLibrary
                self.present(imagePicCtrl, animated: true, completion: nil)
            }
//            self.imagePicker()
        }))
        alertCtrl.addAction(UIAlertAction(title: "保存图片", style: .default, handler: { (action) in
            self.saveImage()
        }))
        alertCtrl.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
            
        }))
        present(alertCtrl, animated: true, completion: nil)
    }    
    
    ///  保存图片
    @objc func saveImage() {
        UIImageWriteToSavedPhotosAlbum(self.avatarImageView.image!, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject) {
        if didFinishSavingWithError == nil {
            MBProgressHUD.show(info: "已保存到相册")
        }  else {
            MBProgressHUD.show(info: "二维码保存失败")
        }
    }
}

extension XCInformationAvatarController: TZImagePickerControllerDelegate {
    
}

