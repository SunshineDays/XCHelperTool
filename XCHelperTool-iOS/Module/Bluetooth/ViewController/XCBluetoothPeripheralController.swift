//
//  XCBluetoothPeripheralController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/10/19.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit
import CoreBluetooth

private let serviceUUID = "CDD1"
private let characteristicUUID = "CCD2"

/// 蓝牙外设设备
class XCBluetoothPeripheralController: BaseViewController {

    private lazy var textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 100, y: 150, width: 200, height: 50))
        textField.layer.borderColor = UIColor.line.cgColor
        textField.layer.borderWidth = 1.pixel
        return textField
    }()
    
    private lazy var postButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        button.setTitle("Post", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(postButtonDidClick(_:)), for: .touchUpInside)
        return button
    }()
    
    private var peripheralManager: CBPeripheralManager?
    private var characteristic: CBMutableCharacteristic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "蓝牙外设设备"
        view.addSubview(textField)
        view.addSubview(postButton)
        peripheralManager = CBPeripheralManager(delegate: self, queue: .main)
    }
}

extension XCBluetoothPeripheralController: CBPeripheralManagerDelegate {
    ///  蓝牙状态
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .unknown:
            print("未知的")
        case .resetting:
            print("重置中")
        case .unsupported:
            print("不支持")
        case .unauthorized:
            print("未验证")
        case .poweredOff:
            print("未启动")
        case .poweredOn:
            print("可用")
            // 创建Service（服务）和Characteristics（特征）
            setupServiceAndCharacteristics()
            // 根据服务的UUID开始广播
            self.peripheralManager?.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [CBUUID(string: serviceUUID)]])
        }
    }
    
    /// 中心设备读取数据的时候回调
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        // 请求中的数据，这里把文本框中的数据发给中心设备
        request.value = self.textField.text?.data(using: .utf8)
        // 成功响应请求
        peripheral.respond(to: request, withResult: .success)
    }
    
    /// 中心设备写入数据
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        let request = requests.last!
        textField.text = String(data: request.value!, encoding: .utf8)
    }
    
    /// 订阅成功回调
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("\(#function) 订阅成功回调")
    }
    
    /// 取消订阅回调
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        print("\(#function) 取消订阅回调")
    }
}

extension XCBluetoothPeripheralController {
    @objc private func postButtonDidClick(_ sende: UIButton) {
        peripheralManager?.updateValue((textField.text ?? "empty").data(using: .utf8)!, for: characteristic!, onSubscribedCentrals: nil)
    }
    
    /** 创建服务和特征
     *  注意swift中枚举的按位运算 '|' 要用[.read, .write, .notify]这种形式
     */
    private func setupServiceAndCharacteristics() {
        let serviceID = CBUUID(string: serviceUUID)
        let service = CBMutableService(type: serviceID, primary: true)
        let characteristicID = CBUUID(string: characteristicUUID)
        let characteristic = CBMutableCharacteristic(type: characteristicID,
                                                     properties: [.read, .write, .notify],
                                                     value: nil,
                                                     permissions: [.readable, .writeable])
        service.characteristics = [characteristic]
        self.peripheralManager?.add(service)
        self.characteristic = characteristic
    }
}
