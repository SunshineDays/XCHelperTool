//
//  DoubleExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/28.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension Double {
    /// 小数位数
    func decimal(_ num: Int) -> String {
        return String(format: "%.\(num)f", self)
    }
    
    /// 金额（每三位用，隔开）
    ///
    /// - Parameter num: 小数位数
    /// - Returns: String
    func moneyText(_ num: Int = 0) -> String {
        var result = ""
        let money = Int(self)
        let moneyStr = money.string.reversed()
        
        for (index, m) in moneyStr.enumerated() {
            result = result + String(m)
            if (index + 1) % 3 == 0 && index + 1 != moneyStr.count {
                result = result + ","
            }
        }
        result = String(result.reversed())
        
        if num > 0 {
            var decimal = (self - Double(money)).decimal(num)
            decimal.removeFirst()
            result = result + decimal
        }
        
        return result
    }
    
    /// 对应的像素值
    var pixel: CGFloat {
        return CGFloat(self) / UIScreen.main.scale
    }

}

extension Double {
    
    /// 时间戳转字符串
    ///
    /// - Parameters:
    ///   - format: 格式 (默认："MM-dd HH:mm")
    ///   - isIntelligent: 是否智能转换(默认为true, true: 显示昨天、今天、明天等格式, false: 按照format格式转换)
    /// - Returns: 按格式转换后的字符串
    func timeString(with format: String = "MM-dd HH:mm", isIntelligent: Bool = true) -> String {
//        "yyyy-MM-dd HH:mm:ss"
        if self < 0 { return "" }
        
        var format = format
        
        let selfDate = Date(timeIntervalSince1970: self)
        
        if isIntelligent {
            if selfDate.isAfterTomorrow() {
                format = "后天 HH:mm"
            } else if selfDate.isTomorrow() {
                format = "明天 HH:mm"
            } else if selfDate.isToday() {
                format = "今天 HH:mm"
            } else if selfDate.isYesterday() {
                format = "昨天 HH:mm"
            } else if selfDate.isBeforeYesterday() {
                format = "前天 HH:mm"
            } else if selfDate.isThisYear() {
                format = "MM-dd HH:mm"
            } else {
                format = "yyyy-MM-dd HH:mm"
            }
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let result = formatter.string(from: Foundation.Date(timeIntervalSince1970: self))        
        return result
    }
}

extension Date {
    
    /// 判断当前日期是否为今年
    func isThisYear() -> Bool {
        // 获取当前\
        let calender = Calendar.current
        // 获取日期的年份
        let yearComps = calender.component(.year, from: self)
        // 获取现在的年份
        let nowComps = calender.component(.year, from: Date())
        
        return yearComps == nowComps
    }
    
    /// 是否是后天
    func isAfterTomorrow() -> Bool {
        return compareDay(-2)
    }
    
    /// 是否是明天
    func isTomorrow() -> Bool {
        return compareDay(-1)
    }
    
    /// 是否是今天
    func isToday() -> Bool {
        return compareDay(0)
    }
    
    /// 是否是昨天
    func isYesterday() -> Bool {
        return compareDay(1)
    }
    
    /// 是否是前天
    func isBeforeYesterday() -> Bool {
        return compareDay(2)
    }

    /// 比较日期
    private func compareDay(_ differDay: Int) -> Bool {
        // 获取当前日历
        let calender = Calendar.current
        
        let nowComps = calender.dateComponents([.year, .month, .day], from: Date())
        
        let selfComps = calender.dateComponents([.year, .month,. day], from: self)
        
        if nowComps.day == nil || selfComps.day == nil {
            return false
        }
        
        return nowComps.year == selfComps.year && nowComps.month == selfComps.month && nowComps.day! - selfComps.day! == differDay
    }
    
}
