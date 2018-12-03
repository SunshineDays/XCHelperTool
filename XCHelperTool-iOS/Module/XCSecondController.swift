//
//  XCSecondController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/5/31.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

class XCSecondController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "2"
        
        
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        backButton.setBackgroundImage(R.image.takeout_back_gray(), for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        let backItem = UIBarButtonItem(customView: backButton)
        
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spaceItem.width = -15
        
        navigationItem.leftBarButtonItems = [spaceItem, backItem]
        
        greatherThanExample()
        
        logIfTrue { () -> Bool in
            return 2 > 1
        }
        logIfTrue({2 > 1})
        logIfTrue{2 > 1}
        logTrue(2 > 1)
    }
    
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func greatherThan(_ comparer: Int) -> (Int) -> Bool {
        return { $0 > comparer }
    }
    func greatherThanExample() {
        let greatherThan8 = greatherThan(10)(8)
        
        let greatherThan12 = greatherThan(10)(12)
        
        if greatherThan8 {
            print("8>10")
        }
        if greatherThan12 {
            print("12>10")
        }
    }
    
    
    func addTo(_ adder: Int) -> (Int) -> Int {
        return { num in
            return num + adder
        }
    }
    
    func logIfTrue(_ predicate: () -> Bool) {
        if predicate() {
            print("13")
        }
    }
    
    func logTrue(_ predicate: @autoclosure () -> Bool) {
        if predicate() {
            print("wr")
        }
    }
    
    
}


protocol PQDataEncodableProtocol {
    associatedtype WarpperType
    
    var pq: WarpperType { get }
}

struct ExtensionPQDataEncodable<T>: PQDataEncodableProtocol {

    let pq: T
    
    init(pq: T) {
        self.pq = pq
    }
    
}

extension PQDataEncodableProtocol where WarpperType == Data  {
    /// 方法名 返回参数
    func toUInt8() -> [UInt8]{
        /// 根据数组长度，创建数组
        var bytes = [UInt8](repeating: 0, count: pq.count)
        /// 把 Data 的 Bytes 拷贝到 数组中
        pq.copyBytes(to: &bytes, count: pq.count)
        /// 返回数组
        return bytes
    }
    
    func toHex() -> String {
        /// 创建一个字符串
        var hex: String = ""
        /// 遍历数组，在转换为16进制添加到字符串中
        for i in 0..<toUInt8().count {
            hex.append(NSString(format: "%02x", pq[i]) as String)
            /// 长度为4就添加一个空格， 格式化字符串
            if (i + 1) % 4 == 0 { hex.append(" ") }
        }
        /// 返回字符串
        return hex
    }

}


extension Data {
    var pq: ExtensionPQDataEncodable<Data> {
        return ExtensionPQDataEncodable(pq: self)
    }
}
