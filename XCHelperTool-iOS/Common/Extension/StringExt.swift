//
//  StringExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/5.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension String {
    /// 字符串截取
    func substring(to index: Int) -> String {
        return (self as NSString).substring(to: index)
    }
    
    /// 字符串截取
    func substring(from index: Int) -> String {
        return (self as NSString).substring(from: index)
    }
    
    /// 字符串截取
    func substring(with range: NSRange) -> String {
        return (self as NSString).substring(with: range)
    }
    
    /// 彩色字符串
    func attributed(font: UIFont, color: UIColor) -> NSAttributedString {
        var attributes = [NSAttributedString.Key : Any]()
        attributes[.font] = font
        attributes[.foregroundColor] = color
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    /// 拨打电话
    func call() {
        let tel = "tel:" + self
        if let url = URL(string: tel) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /// 打开指定QQ的聊天界面
    func chatToQQ() {
        let qq = "mqq://im/chat?chat_type=wpa&uin=" + self + "&version=1&src_type=web"
        if let url = URL(string: qq) {
            if UIApplication.shared.canOpenURL(url) {
                let webView = UIWebView(frame: CGRect.zero)
                let request = URLRequest(url: url)
                webView.loadRequest(request)
                UIApplication.shared.keyWindow?.addSubview(webView)
            }
            else {
                MBProgressHUD.show(info: "您还没有安装QQ")
            }
        }
    }
}

extension String {
    ///  字符串高度（在label中的高度）
    ///
    /// - Parameters:
    ///   - textWidth: 文本宽度
    ///   - font: 文本字体大小
    /// - Returns: 文本高度
    func textHeight(textWidth: CGFloat, font: UIFont) -> CGFloat {
        let labelText: NSString = self as NSString
        let size = CGSize(width: textWidth, height: 1000)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedString.Key : Any]), context:nil).size
        return strSize.height
    }
    
    ///  字符串宽度（在label中的宽度）
    ///
    /// - Parameters:
    ///   - textHeight: 文本高度
    ///   - font: 文本字体大小
    /// - Returns: 文本宽度
    func textWidth(textHeight: CGFloat, font: UIFont) -> CGFloat {
        let labelText: NSString = self as NSString
        let size = CGSize(width: 1000, height: textHeight)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedString.Key : Any]), context:nil).size
        return strSize.width
    }
}

extension String {
    /// 设置html界面的颜色和字体大小
    ///
    /// - Parameters:
    ///   - color: 颜色（#666666）
    ///   - font: 字体大小
    /// - Returns: HTML字符串
    func htmlString(color: String, font: Int) -> String {
        return String(format: "<span style=\"font-size:%dpx;color:%@\">%@</span>", font, color, self)
    }
    
    /// 设置html界面的格式
    ///
    /// - Parameters:
    /// - Returns: HTML字符串
    func htmlString() -> String {
        return """
        <!doctype html>
        <html>
        <head>
        <meta charset='utf-8'/>
        <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=no'/>
        <meta name='format-detection' content='telephone=no' />
        <link href='web/label/labelContent.css' rel='stylesheet'/>
        </head>
        <body>
        <article id='content'>
        \(self)
        </article>
        </body>
        </html>
        """
    }
}

extension String {
    /// MD5加密
    var md5: String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        if let data = data(using: .utf8) {
            data.withUnsafeBytes { (bytes) -> Void in
                CC_MD5(bytes, CC_LONG(data.count), &digest)
            }
        }
        var digestHex = ""
        for index in 0 ..< Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        return digestHex
    }
    
    /// string -> base64
    var base64Encode: String {
        let data = self.data(using: String.Encoding.utf8)
        let resultString = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0)))
        return resultString ?? ""
    }
    
    /// base64 -> string
    var base64Decode: String {
        let data = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0))
        let resultString = String(data:data! as Data, encoding:String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        return resultString ?? ""
    }

    /// 去掉字符串中的空格
    var full: String {
//        return replacingOccurrences(of: " ", with: "")
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// 电话号码格式(输出类似 188 1234 1234 的电话号码)）
    var mobile: String {
        if isMobile() {
            return substring(to: 2) + " " + substring(with: NSRange(location: 3, length: 4)) + " " + substring(from: 7)
        } else {
            return self
        }
    }
    
    /// 电话号码格式(输出类似 188******88 的电话号码)）
    var mobileSecurity: String {
        if isMobile() {
            let result = full
            return result.substring(to: 2) + "******" + result.substring(from: count - 2)
        } else {
            return self
        }
    }    
    
    /// 银行卡号格式(输出类似 6666 6666 6666 6666 6666 的银行卡号)
    var bankCard: String {
        var result = ""
        for (index, string) in enumerated() {
            result = result + String(string)
            if index % 5 == 0 {
                result = result + " "
            }
        }
        return result
    }
    
    /// 银行卡号格式(输出类似 **** **** **** 6666 的银行卡号)
    var bankCardSecurity: String {
        let result = full
        return "**** **** **** " + result.substring(from: count - 4)
    }
    
    /// 身份证号码格式(输出类似 666666 1999 0802 0000 的身份证号码)
    var idCard: String {
        if isIDCard() {
            return substring(to: 5) + " " + substring(with: NSRange(location: 6, length: 4)) + " " + substring(with: NSRange(location: 10, length: 4)) + " "  + substring(from: 14)
        } else {
            return self
        }
    }

    /// 身份证号码格式(输出类似 6****************0 的身份证号码)
    var idCardSecurity: String {
        if isIDCard() {
            let result = full
            return result.substring(to: 0) + "****************" + result.substring(from: count - 1)
        } else {
            return self
        }
    }
}

extension String {
    /// 是否是手机号码
    func isMobile(showError: Bool = false) -> Bool {
        //手机号以13,15,17,18开头，八个 \d 数字字符
        let regex: String = "^((13[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let isMobile = test.evaluate(with: full)
        if showError && !isMobile {
            MBProgressHUD.show(info: "请输入正确的手机号码")
        }
        return isMobile
    }
    
    /// 是否是固定电话
    func isTel(showError: Bool = false) -> Bool {
        //010,020,021,022,023,024,025,027,028,029,400
        let regex: String = "^((0(10|2[0-5789]|\\d{3}))|(400))\\d{7,8}$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let isTel = test.evaluate(with: full)
        if showError && !isTel {
            MBProgressHUD.show(info: "电话号码格式错误")
        }
        return isTel
    }
    
    /// 是否是邮箱
    func isEmail(showError: Bool = false) -> Bool {
        let regex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let isEmail = test.evaluate(with: self)
        if showError && !isEmail {
            MBProgressHUD.show(info: "邮箱格式错误")
        }
        return isEmail
    }
    
    /// 是否是身份证号码
    func isIDCard(showError: Bool = false) -> Bool {
        let regex: String = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let isIDCard = test.evaluate(with: full)
        if showError && !isIDCard {
            MBProgressHUD.show(info: "身份证号码格式错误")
        }
        return isIDCard
    }    
}

extension String {
    /// 生成一张普通的二维码
    ///
    /// - Returns: 二维码图片
    func qrCodeImage() -> UIImage? {
        return QRCodeTool.qrCode(qrCodeData: self)
    }
    
    /// 生成一张带有logo的二维码
    ///
    /// - Parameters:
    ///   - logoImage: logo的image
    ///   - scale: logo相对于父视图的缩放比（取值范围：0-1，0:代表不显示，1:代表与父视图大小相同）
    ///   - isShowLogoJamb: logo是否有白色边框
    /// - Returns: 带有logo的二维码图片
    func qrCodeWithLogoImage(logoImage: UIImage,
            logoScaleToSuperView scale: CGFloat = 0.2,
                        isShowLogoJamb: Bool = true) -> UIImage? {
        return QRCodeTool.qrCodeWithLogo(qrCodeData: self, logoImage: logoImage, logoScaleToSuperView: scale, isShowLogoJamb: isShowLogoJamb)
    }
    
    /// 彩色二维码
    ///
    /// - Parameters:
    ///   - data: 传入你要生成二维码的数据
    ///   - backgroundColor: 背景色
    ///   - mainColor: 主颜色恶（二维码颜色）
    /// - Returns: 彩色二维码图片
    func qrCodeWithColorImage(backgroundColor: UIColor,
                                    mainColor: UIColor) -> UIImage? {
        return QRCodeTool.qrCodeWithColor(qrCodeData: self, backgroundColor: backgroundColor, mainColor: mainColor)
    }
}
