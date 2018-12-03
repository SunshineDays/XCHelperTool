//
//  XCChatUpType.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/25.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 弹幕弹窗内容
enum XCChatUpType {
    
    case speedKey
    
    case fontKey
    
    case styleKey
    
    case colorKey
    
    var key: String {
        switch self {
        case .speedKey: return "speedKey"
        case .fontKey: return "fontKey"
        case .styleKey: return "styleKey"
        case .colorKey: return "colorKey"
        }
    }
    
    enum speed: Int {
        case s00 = 10
        case s05 = 11
        case s10 = 12
        case s15 = 13
        case s20 = 14
        
        var speed: Double {
            switch self {
            case .s00: return 0
            case .s05: return 0.5
            case .s10: return 1.0
            case .s15: return 1.5
            case .s20: return 2.0
            }
        }
        
        var name: String {
            switch self {
            case .s00: return "0"
            case .s05: return "0.5X"
            case .s10: return "1.0X"
            case .s15: return "1.5X"
            case .s20: return "2.0X"
            }
        }
    }
    
    enum font: Int {
        case f24 = 20
        case f36 = 21
        case f48 = 22
        case f64 = 23
        case f72 = 24
        case f90 = 25
        
        var font: CGFloat {
            switch self {
            case .f24: return 24 * 3
            case .f36: return 36 * 3
            case .f48: return 48 * 3
            case .f64: return 64 * 3
            case .f72: return 72 * 3
            case .f90: return 90 * 3
            }
        }
        
        var name: String {
            switch self {
            case .f24: return "24"
            case .f36: return "36"
            case .f48: return "48"
            case .f64: return "64"
            case .f72: return "72"
            case .f90: return "90"
            }
        }
    }
    
    enum style: Int {
        case s00 = 30
        case s01 = 31
        case s02 = 32
        case s03 = 33
        case s04 = 34
        
        func style(_ font: CGFloat) -> UIFont {
            switch self {
            case .s00: return UIFont.systemFont(ofSize: font)
            case .s01: return UIFont.italicSystemFont(ofSize: font)
            case .s02: return UIFont.boldSystemFont(ofSize: font)
            case .s03: return UIFont(name: UIFont.familyNames[10], size: font)!
            case .s04: return UIFont(name: UIFont.familyNames[20], size: font)!
            }
        }
    }
    
    enum color: Int {
        case white = 40
        case red = 41
        case yellow = 42
        case magenta = 43
        case green = 44
        case blue = 45
        
        var color: UIColor {
            switch self {
            case .white: return UIColor.white
            case .red: return UIColor.red
            case .yellow: return UIColor.yellow
            case .magenta: return UIColor.magenta
            case .green: return UIColor.green
            case .blue: return UIColor.blue
            }
        }
    }
}
