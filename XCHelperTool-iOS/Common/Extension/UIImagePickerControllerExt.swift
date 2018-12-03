//
//  UIImagePickerControllerExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/9/21.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension UIImagePickerController {
    /// 获取选取的图片
    func image(info: [UIImagePickerController.InfoKey : Any]) -> UIImage? {
        if allowsEditing {
            if let editedImage = info[.editedImage] {
                let image = editedImage as! UIImage
                return image
            }
        } else {
            if let originalImage = info[.originalImage] {
                let image = originalImage as! UIImage
                return image
            }
        }
        return nil
    }
}
