//
//  XCBluetoothController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/10/19.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit
import CoreBluetooth

private let serviceUUID = "CDD1"
private let charcteristicUUID = "CDD2"

/// 蓝牙中心设备
class XCBluetoothController: BaseViewController {

    private lazy var textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 100, y: 150, width: 200, height: 50))
        textField.layer.borderColor = UIColor.line.cgColor
        textField.layer.borderWidth = 1.pixel
        return textField
    }()
    
    private lazy var getButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 200, width: 50, height: 50))
        button.setTitle("get", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(getButtonDidClick(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var postButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 200, y: 200, width: 50, height: 50))
        button.setTitle("post", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(postButtonDidClick(_:)), for: .touchUpInside)
        return button
    }()
    
    private var centralManager: CBCentralManager?
    private var peripheral: CBPeripheral?
    private var characteristic: CBCharacteristic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "蓝牙中心设备"
        view.addSubview(textField)
        view.addSubview(getButton)
        view.addSubview(postButton)
        centralManager = CBCentralManager(delegate: self, queue: .main)
    }

}


extension XCBluetoothController: CBCentralManagerDelegate, CBPeripheralDelegate {
    /// 判断手机蓝牙状态
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
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
            central.scanForPeripherals(withServices: [CBUUID(string: serviceUUID)], options: nil)
        }
    }
    
    /// 发现符合要求的外设
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        self.peripheral = peripheral
        central.connect(peripheral, options: nil)
    }
    
    /// 连接成功
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.centralManager?.stopScan()
        peripheral.delegate = self
        peripheral.discoverServices([CBUUID(string: serviceUUID)])
        print("连接成功")
    }
    
    /// 连接失败
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("连接失败")
    }
    
    /// 断开连接
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("断开连接")
        // 重新连接
        central.connect(peripheral, options: nil)
    }
    
    /// 发现服务
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services! {
            print("外设中的服务有:\(service)")
        }
        // 本例的外设中只有一个服务
        let service = peripheral.services?.last
        // 根据UUID寻找服务中的特征
        peripheral.discoverCharacteristics([CBUUID(string: charcteristicUUID)], for: service!)
    }
    
    /// 发现特征
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic in service.characteristics! {
            print("外设中的特征有：\(characteristic)")
        }
        self.characteristic = service.characteristics?.last
        // 读取特征里的数据
        peripheral.readValue(for: self.characteristic!)
        // 订阅
        peripheral.setNotifyValue(true, for: self.characteristic!)
    }
    
    /// 订阅状态
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("订阅失败:\(error)")
            return
        }
        if characteristic.isNotifying {
            print("订阅成功")
        } else {
            print("取消订阅")
        }
    }
    
    /// 接收到数据
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        let data = characteristic.value
        textField.text = String(data: data!, encoding: String.Encoding.utf8)
    }
    
    /// 写入数据
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("写入数据")
    }
}

extension XCBluetoothController {
    @objc private func getButtonDidClick(_ sneder: UIButton) {
        peripheral?.readValue(for: characteristic!)
    }
    
    @objc private func postButtonDidClick(_ sneder: UIButton) {
        let data = (textField.text ?? "empty").data(using: .utf8)
        peripheral?.writeValue(data!, for: characteristic!, type: .withResponse)
    }
}
