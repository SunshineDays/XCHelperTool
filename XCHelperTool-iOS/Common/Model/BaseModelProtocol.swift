//
//  BaseModelProtocol.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/12.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

protocol BaseModelProtocol: CustomStringConvertible {
    
    var json: JSON { get set }
    
    init(json: JSON)
}

extension BaseModelProtocol {
    var description: String {
        return json.description
    }
}
