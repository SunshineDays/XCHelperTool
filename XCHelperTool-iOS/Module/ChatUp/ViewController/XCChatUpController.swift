//
//  XCChatUpController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/23.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit
import CoreData

/// 弹幕弹窗
class XCChatUpController: BaseViewController {
    
    @IBOutlet weak var settingView: UIView!
    
    @IBOutlet weak var lockButton: UIButton!
    
    @IBOutlet weak var settingButton: UIButton!
    
    @IBOutlet weak var writeButton: UIButton!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    private var timeInterval: TimeInterval = 0.0015
    
    private var timer: Timer?
    
    private var changeFrame: CGFloat = 0.6
    
    private var chatupContext: NSManagedObjectContext!
    
    private var chatupModel = XCChatUp()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        getCoreData()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTitle()
        timer?.invalidate()
        timer = nil
        addTimer()
        
        UIApplication.shared.isStatusBarHidden = true
        UIApplication.shared.isIdleTimerDisabled = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
}

extension XCChatUpController {
    
    private func getTitle() {
        let historyContext = CoreDataTool.managedObjectContext(.chatupHistory)
        if let results = CoreDataTool.list(historyContext, entityName: .chatupHistory) {
            var models = [XCChatUpWriteHistory]()
            for r in results {
                let model = r as! XCChatUpWriteHistory
                models.append(model)
            }
            if models.count > 0 {
                models.sort { $0.createTime > $1.createTime }
                contentLabel.text = models.first?.title
            } else {
                contentLabel.text = "点击右上角输入弹幕内容"
            }
        }
    }
    
    /// 设置信息
    private func getCoreData() {
        chatupContext = CoreDataTool.managedObjectContext(.chatupSetting)
        if let results = CoreDataTool.list(chatupContext, entityName: .chatupSetting) {
            if let r = results.first {
                chatupModel = r as! XCChatUp
            } else {
                let model: XCChatUp = NSEntityDescription.insertNewObject(forEntityName: CoreDataEntityNameType.chatupSetting.rawValue, into: chatupContext) as! XCChatUp
                model.speed = Int16(XCChatUpType.speed.s10.rawValue)
                model.font = Int16(XCChatUpType.font.f64.rawValue)
                model.style = Int16(XCChatUpType.style.s00.rawValue)
                model.color = Int16(XCChatUpType.color.white.rawValue)
                CoreDataTool.save(chatupContext)
                chatupModel = model
            }
        }
    }
    
    private func initView() {
        contentLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
        
        let style = XCChatUpType.style(rawValue: Int(chatupModel.style))!
        let font = style.style((XCChatUpType.font(rawValue: Int(chatupModel.font))?.font)!)
        contentLabel.font = font
        
        contentLabel.textColor = XCChatUpType.color(rawValue: Int(chatupModel.color))?.color
        changeFrame = CGFloat(0.6) * CGFloat((XCChatUpType.speed(rawValue: Int(chatupModel.speed))?.speed)!)
    }
    
    private func addTimer() {
        timer = Timer(timeInterval: timeInterval, repeats: true, block: { (timer) in
            self.contentLabel.frame.origin.y = self.contentLabel.frame.origin.y - self.changeFrame
            if self.contentLabel.frame.maxY < 0 {
                self.contentLabel.frame.origin.y = (self.contentLabel.superview?.frame.maxY)!
            }
        })
        RunLoop.main.add(timer!, forMode: .common)
    }
}

extension XCChatUpController: XCChatUpSettingControllerDelegate {
    func chatupSetting(_ ctrl: UIViewController, model: XCChatUp) {
        if XCChatUpType.speed(rawValue: Int(model.speed)) == XCChatUpType.speed.s00 {
            changeFrame = 0
        } else {
            changeFrame = CGFloat(0.6) * CGFloat((XCChatUpType.speed(rawValue: Int(model.speed))?.speed)!)
        }
        let style = XCChatUpType.style(rawValue: Int(model.style))!
        let font = style.style((XCChatUpType.font(rawValue: Int(model.font))?.font)!)
        contentLabel.font = font
        contentLabel.textColor = XCChatUpType.color(rawValue: Int(model.color))?.color
    }
}

extension XCChatUpController {
    
    @IBAction func writeAction(_ sender: UIButton) {
        let vc = R.storyboard.xcChatUp.xcChatUpWriteController()!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func lockAction(_ sender: UIButton) {
        lockButton.isSelected = !lockButton.isSelected
        if lockButton.isSelected {
            settingButton.isHidden = true
            writeButton.isHidden = true
        } else {
            settingButton.isHidden = false
            writeButton.isHidden = false
        }
    }
    
    @IBAction func settingAction(_ sender: UIButton) {
        let vc = R.storyboard.xcChatUp.xcChatUpSettingController()!
        vc.delegate = self
        UIApplication.shared.keyWindow?.rootViewController?.addChild(vc)
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(vc.view)
    }
    
    @IBAction func settingHiddenAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        settingView.isHidden = sender.isSelected
    }
    
}
