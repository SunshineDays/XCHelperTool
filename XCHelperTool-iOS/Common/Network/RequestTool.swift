//
//  NetworkTool.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/9/26.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 网络请求
class RequestTool: NSObject {
    
    typealias SuccessfulBlock = (_ json: SwiftyJSON.JSON) -> Void
    
    typealias FailedBlock = (_ error: Error) -> ()
    
    /// 数据请求
    ///
    ///   - parameter: ParameterResult
    ///   - success: 成功回调（JSON）
    ///   - failed: 失败回调（Error)
    public class func request(parameter: ParameterResult,
                              success: @escaping SuccessfulBlock,
                              failed: @escaping FailedBlock)
    {
        let requestURL = kBbaseURL + parameter.pathURL
        let requestParameters = requestParameter(parameter: parameter.parameter)
        Alamofire.request(requestURL, method: .post, parameters: requestParameters).responseJSON { (r) in
            switch r.result {
            case .success(let value):
                success(JSON(value))
            case .failure(let error):
                failed(error)
                NotificationCenter.default.post(name: UserNotification.shouldLogin.notification, object: nil)
            }
        }
    }
    
    /// 拼接公共参数
    private class func requestParameter(parameter: [String: Any]?) -> [String: Any] {
        var result = parameter ?? [:]
        result["token"] = "13212312314444"
        return result
    }
}


