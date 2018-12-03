//
//  SettingTool.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/10.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit
import AudioToolbox

/// APP信息
class AppInfoTool: NSObject {
    
    /// 获取APP版本号
    class func appName() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    
    /// 获取APP版本号
    class func appVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    /// 获取Build id
    class func appBuild() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
    
    /// UUID
    class func iOSDeviceID() -> String {
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
    
    /// 获取系统版本号
    class func iOSVersion() -> String {
        return UIDevice.current.systemVersion
    }
}

/// 媒体
class MediaTool: NSObject {
    override init() {
        super.init()
        let path = Bundle.main.path(forResource: "goal", ofType: "wav", inDirectory: "Resource.bundle/sound")
        if let path = path {
            let url = URL(fileURLWithPath: path) as CFURL
            AudioServicesCreateSystemSoundID(url, &soundID)
        }
    }
    
    private var soundID = SystemSoundID(0)
    
    // 播放声音
    public func playSound() {
        AudioServicesPlaySystemSound(soundID)
    }
    
    // 播放震动
    public func playVibrate() {
        AudioServicesPlaySystemSound(UInt32(kSystemSoundID_Vibrate))
    }
}

/// 键盘
class KeyBoardTool: NSObject {
    /// 键盘高度
    class func keyBoardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        //获取键盘的size
        let rect = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //键盘高度
        return rect.size.height
    }
    
    /// 键盘弹出时间
    class func keyBoardDuration(_ notification: Notification) -> Double {
        let userInfo = notification.userInfo
        let duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        return duration
    }
}
