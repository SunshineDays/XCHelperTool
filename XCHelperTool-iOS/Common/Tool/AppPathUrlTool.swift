//
//  AppPathUrlTool.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/14.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 页面URL路径
class AppPathUrlTool: NSObject {
    /// 通过URL跳转到对应界面
    public class func pushToViewController(url: URL) {
        let path = urlPath(url: url)
        switch path {
        case .home:             push(InterfaceTool.homePageController())
        case .chatup:           push(InterfaceTool.chatupController())
        case .remind:           push(InterfaceTool.remindController())
        case .userInfo:         push(InterfaceTool.userInfoController())
        case .userIssue:        push(InterfaceTool.userIssueController())
        case .userFollow:       push(InterfaceTool.userFollowController())
        case .userFans:         push(InterfaceTool.userFansController())
        case .userVip:          push(InterfaceTool.userVipController())
        case .userBalance:      push(InterfaceTool.userBlanceController())
        case .userBill:         push(InterfaceTool.userBillController())
        case .userBankCard:     push(InterfaceTool.userBankCardController())
        case .topicDetail:      push(InterfaceTool.topicDetailController(id: parameter(url: url, key: "id")))
        default: break
        }
    }
    
    /// 根据URL中的 参数名 获取 参数内容
    public class func parameter(url: URL, key: String) -> String {
        var result = url.absoluteString
        if !result.contains(key) {
            return ""
        } else {
            let range: NSRange = (result as NSString).range(of: key + "=")
            let lastIndex = range.location + range.length
            
            var ands = [Int]() // &的下标数组
            for (i, r) in result.enumerated() {
                if r == "&" {
                    ands.append(i)
                }
            }
            if ands.count == 0 {
                result = result.substring(from: lastIndex)
                return result
            } else {
                for a in ands {
                    if a - lastIndex > 0 {
                        result = result.substring(with: NSRange(location: lastIndex, length: a - lastIndex))
                        return result
                    }
                }
                if let _ = ands.index(where: { $0 > lastIndex }) {
                    return result
                } else {
                    result = result.substring(from: lastIndex)
                    return result
                }
            }
        }
    }
    
    private class func push(_ controller: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            PublicTool.rootViewController().pushViewController(controller, animated: true)
        }
    }
    
    /// 通过url判断类型
    private class func urlPath(url: URL) -> AppPathURLType {
        var result = url.absoluteString
        result = result.replacingOccurrences(of: "sunshine://", with: "")
        let index = result.index(where: { $0 == "?" })
        if let index = index {
            result = result.substring(to: index.encodedOffset)
        }
        return AppPathURLType(rawValue: result) ?? .home
    }
    

}



