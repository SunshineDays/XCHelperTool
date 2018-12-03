//
//  XCChatUpSettingController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/23.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit
import CoreData

protocol XCChatUpSettingControllerDelegate: class {
    func chatupSetting(_ ctrl: UIViewController, model: XCChatUp)
}

/// 弹幕弹窗设置
class XCChatUpSettingController: UIViewController {

    @IBOutlet weak var buttonsView: UIView!
    
    @IBOutlet weak var speed00Button: UIButton!
    @IBOutlet weak var speed05Button: UIButton!
    @IBOutlet weak var speed10Button: UIButton!
    @IBOutlet weak var speed15Button: UIButton!
    @IBOutlet weak var speed20Button: UIButton!
    
    @IBOutlet weak var font24Button: UIButton!
    @IBOutlet weak var font36Button: UIButton!
    @IBOutlet weak var font48Button: UIButton!
    @IBOutlet weak var font64Button: UIButton!
    @IBOutlet weak var font72Button: UIButton!
    @IBOutlet weak var font90Button: UIButton!

    @IBOutlet weak var style01Button: UIButton!
    @IBOutlet weak var style02Button: UIButton!
    @IBOutlet weak var style03Button: UIButton!
    @IBOutlet weak var style04Button: UIButton!
    @IBOutlet weak var style05Button: UIButton!

    @IBOutlet weak var colorWhiteButton: UIButton!
    @IBOutlet weak var colorRedButton: UIButton!
    @IBOutlet weak var colorYellowButton: UIButton!
    @IBOutlet weak var colorMagentaButton: UIButton!
    @IBOutlet weak var colorGreenButton: UIButton!
    @IBOutlet weak var colorBlueButton: UIButton!
    
    private var speedButtons = [UIButton]()
    private var fontButtons = [UIButton]()
    private var styleButtons = [UIButton]()
    private var colorButtons = [UIButton]()
    
    private var chatupContext: NSManagedObjectContext!
    
    private var chatupModel = XCChatUp()
    
    public weak var delegate: XCChatUpSettingControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCoreData()
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension XCChatUpSettingController {
    
    private func getCoreData() {
        chatupContext = CoreDataTool.managedObjectContext(.chatupSetting)
        if let results = CoreDataTool.list(chatupContext, entityName: .chatupSetting) {
            if let r = results.first {
                chatupModel = r as! XCChatUp
            }
        }
    }
    
    private func initView() {
        for view in buttonsView.subviews {
            if view is UIButton {
                view.layer.masksToBounds = true
                view.layer.cornerRadius = view.frame.width / 2
                view.layer.borderColor = UIColor.white.cgColor
                view.layer.borderWidth = 0
            }
        }
        speedButtons = [speed00Button, speed05Button, speed10Button, speed15Button, speed20Button]
        fontButtons = [font24Button, font36Button, font48Button, font64Button, font72Button, font90Button]
        styleButtons = [style01Button, style02Button, style03Button, style04Button, style05Button]
        colorButtons = [colorWhiteButton, colorRedButton, colorYellowButton, colorMagentaButton, colorGreenButton, colorBlueButton]

        let speedTitles: [XCChatUpType.speed] = [.s00, .s05, .s10, .s15, .s20]
        for (index ,button) in speedButtons.enumerated() {
            button.setTitle(speedTitles[index].name, for: .normal)
            if button.tag == chatupModel.speed {
                button.layer.borderWidth = 0.5
            }
        }

        let fontTitles: [XCChatUpType.font] = [.f24, .f36, .f48, .f64, .f72, .f90]
        for (index, button) in fontButtons.enumerated() {
            button.setTitle(fontTitles[index].name, for: .normal)
            if button.tag == chatupModel.font {
                button.layer.borderWidth = 0.5
            }
        }

        let styleFonts: [XCChatUpType.style] = [.s00, .s01, .s02, .s03, .s04]
        for (index, button) in styleButtons.enumerated() {
            button.titleLabel?.font = styleFonts[index].style(14)
            if button.tag == chatupModel.style {
                button.layer.borderWidth = 0.5
            }
        }

        let colorBackgroundColors: [XCChatUpType.color] = [.white, .red, .yellow, .magenta, .green, .blue]
        for (index, button) in colorButtons.enumerated() {
            button.backgroundColor = colorBackgroundColors[index].color
            if button.tag == chatupModel.color {
                button.layer.borderWidth = 0.5
            }
        }
    }
}

extension XCChatUpSettingController {
    @IBAction func dismissAction(_ sender: UIButton) {

        view.removeFromSuperview()
        removeFromParent()
    }

    @IBAction func speenAction(_ sender: UIButton) {
        editCoreData(speed: Int16(sender.tag), sender: sender)

    }

    @IBAction func fontAction(_ sender: UIButton) {
        editCoreData(font: Int16(sender.tag), sender: sender)
    }

    @IBAction func styleAction(_ sender: UIButton) {
        editCoreData(style: Int16(sender.tag), sender: sender)
    }

    @IBAction func colorAction(_ sender: UIButton) {
        editCoreData(color: Int16(sender.tag), sender: sender)
    }
    
    
    private func editCoreData(speed: Int16? = nil, font: Int16? = nil, style: Int16? = nil, color: Int16? = nil, sender: UIButton) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityNameType.chatupSetting.rawValue)
        
        var chatup = [XCChatUp]()
        do {
            chatup = try chatupContext.fetch(fetchRequest) as! [XCChatUp]
        } catch {
            fatalError()
        }
        if let model = chatup.first {
            if let speed = speed {
                model.speed = speed
                changeBorderColor(sender, buttons: speedButtons)
            }
            if let font = font {
                model.font = font
                changeBorderColor(sender, buttons: fontButtons)
            }
            if let style = style {
                model.style = style
                changeBorderColor(sender, buttons: styleButtons)
            }
            if let color = color {
                model.color = color
                changeBorderColor(sender, buttons: colorButtons)
            }
            CoreDataTool.save(chatupContext)
            delegate?.chatupSetting(self, model: model)
        }        
    }
    
    
    private func changeBorderColor(_ sender: UIButton, buttons: [UIButton]) {
        for button in buttons {
            if button == sender {
                button.layer.borderWidth = 0.5
            } else {
                button.layer.borderWidth = 0
            }
        }
    }
    
}




