//
//  QRCodeTool.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/5.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 二维码
class QRCodeTool: NSObject {

    /// 生成一张普通的二维码
    ///
    /// - Parameter data: 传入你要生成二维码的数据
    /// - Returns: 二维码图片
    public class func qrCode(qrCodeData data: String) -> UIImage?
    {
        return UIImage(ciImage: ciImage(qrCodeData: data))
    }

    
    /// 生成一张带有logo的二维码
    ///
    /// - Parameters:
    ///   - data: 传入你要生成二维码的数据
    ///   - logoImage: logo的image
    ///   - scale: logo相对于父视图的缩放比（取值范围：0-1，0:代表不显示，1:代表与父视图大小相同）
    ///   - isShowLogoJamb: logo是否有白色边框
    /// - Returns: 带有logo的二维码图片
    public class func qrCodeWithLogo(qrCodeData data: String,
                                           logoImage: UIImage,
                          logoScaleToSuperView scale: CGFloat,
                                      isShowLogoJamb: Bool = true) -> UIImage?
    {
        var outputImage = ciImage(qrCodeData: data)
        
        outputImage = outputImage.transformed(by: CGAffineTransform(scaleX: 20, y: 20))
        // 4、将CIImage类型转成UIImage类型
        let startImage = UIImage(ciImage: outputImage)
        
        // - - - - - - - - - - - - - - - - 添加中间小图标 - - - - - - - - - - - - - - - -
        // 5、开启绘图, 获取图形上下文 (上下文的大小, 就是二维码的大小)
        UIGraphicsBeginImageContext(startImage.size)
        // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
        startImage.draw(in: CGRect(x: 0, y: 0, width: startImage.size.width, height: startImage.size.height))
        
        // logo图片
        var iconImage = UIImage()
        
        if isShowLogoJamb {
            iconImage = addWatermakerImage(backgroundImage: UIColor.white.convertToImage(), watermarkImage: logoImage, backgroundImageRect: CGRect(x: 0, y: 0, width: 110, height: 110), watermarkImageRect: CGRect(x: 5, y: 5, width: 100, height: 100))!
        } else {
            iconImage = logoImage
        }
        
        let iconImageW = startImage.size.width * scale
        let iconImageH = startImage.size.height * scale
        let iconImageX = (startImage.size.width - iconImageW) * 0.5
        let iconImageY = (startImage.size.height - iconImageH) * 0.5
        
        iconImage.draw(in: CGRect(x: iconImageX, y: iconImageY, width: iconImageW, height: iconImageH))
        // 6、获取当前画得的这张图片
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        // 7、关闭图形上下文
        UIGraphicsEndImageContext()
        
        return finalImage
    }

    
    /// 彩色二维码
    ///
    /// - Parameters:
    ///   - data: 传入你要生成二维码的数据
    ///   - backgroundColor: 背景色
    ///   - mainColor: 主颜色恶（二维码颜色）
    /// - Returns: 彩色二维码图片
    public class func qrCodeWithColor(qrCodeData data: String,
                                      backgroundColor: UIColor,
                                            mainColor: UIColor) -> UIImage?
    {
        // 3、获得滤镜输出的图像
        var outputImage = ciImage(qrCodeData: data)
        // 图片小于(27,27),我们需要放大
        outputImage = outputImage.transformed(by: CGAffineTransform(scaleX: 9, y: 9))
        // 4、创建彩色过滤器(彩色的用的不多)
        let colorFilter = CIFilter(name: "CIFalseColor")
        // 设置默认值
        colorFilter?.setDefaults()
        // 5、KVC 给私有属性赋值
        colorFilter?.setValue(outputImage, forKey: "inputImage")
        // 6、需要使用 CIColor
        colorFilter?.setValue(backgroundColor, forKey: "inputColor0")
        colorFilter?.setValue(mainColor, forKey: "inputColor1")
        // 7、设置输出
        let colorImage = colorFilter?.outputImage
        
        return UIImage(ciImage: colorImage!)
    }
    
    
    /// 给图片添加水印
    ///
    /// - Parameters:
    ///   - backgroundImage: 背景图片
    ///   - watermarkImage: 水印图片
    ///   - backgroundImageRect: 背景图片Rect
    ///   - watermarkImageRect: 水印图片Rect
    /// - Returns: 添加了水印的图片
    public class func addWatermakerImage(backgroundImage: UIImage,
                                          watermarkImage: UIImage,
                                     backgroundImageRect: CGRect,
                                      watermarkImageRect: CGRect) -> UIImage?
    {
        // 创建一个graphics context来画我们的东西
        UIGraphicsBeginImageContext(backgroundImageRect.size)
        // graphics context就像一张能让我们画上任何东西的纸。我们要做的第一件事就是把person画上去
        backgroundImage.draw(in: CGRect(x: 0, y: 0, width: backgroundImageRect.size.width, height: backgroundImageRect.size.height))
        // 然后在把hat画在合适的位置
        watermarkImage.draw(in: CGRect(x: watermarkImageRect.origin.x, y: watermarkImageRect.origin.y, width: watermarkImageRect.size.width, height: watermarkImageRect.size.height))
        // 通过下面的语句创建新的UIImage
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        // 最后，我们必须得清理并关闭这个再也不需要的context
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    /// 生成二维码（CIImage）
    private class func ciImage(qrCodeData data: String) -> CIImage
    {
        // 1、创建滤镜对象
        let filter = CIFilter(name: "CIQRCodeGenerator")
        // 恢复滤镜的默认属性
        filter?.setDefaults()
        
        // 2、设置数据
        let info = data
        // 将字符串转换
        let infoData = info.data(using: String.Encoding.utf8)
        // 通过KVC设置滤镜inputMessage数据
        filter?.setValue(infoData, forKeyPath: "inputMessage")
        
        // 3、获得滤镜输出的图像
        let outputImage = filter?.outputImage
        return outputImage!
    }

    
}
