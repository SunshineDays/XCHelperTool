//
//  RemindWriteController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/1.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit
import CoreData

enum RemindType {
    case add
    case edit
}

/// 创建提醒
class XCRemindWriteController: BaseTableViewController {
    
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBOutlet weak var remarkTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var repeatLabel: UILabel!
    
    @IBOutlet weak var saveSwitch: UISwitch!
    
    @IBOutlet weak var markTypeLabel: UILabel!
    
    /// 页面类型
    private var remindType: RemindType = .add
    /// 重复规则
    private var repeatType: XCRemindRepeatType = .none
    /// 事件类型
    private var markType: XCRemindMarkType = .none
    
    private var remindContext: NSManagedObjectContext!
    
    /// 模型（编辑时上个界面传过来的）
    private var remindModel = XCRemind()
    
    private var remindID: Int64 = 0
    
    public func initWith(model: XCRemind? = nil, remindType: RemindType) {
        self.remindType = remindType
        if let model = model {
            remindModel = model
            repeatType = XCRemindRepeatType(rawValue: Int(model.repeatType)) ?? .none
            markType = XCRemindMarkType(rawValue: Int(model.markType)) ?? .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remindContext = CoreDataTool.managedObjectContext(.remind)
        initView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if remindType == .edit {
//            finish()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeaderInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kFooterInSectionHeight
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (2, 0): markTypeAction()
        default: break
        }
    }
    
}

extension XCRemindWriteController {
    private func initView(){
        
        datePicker.minimumDate = Date(timeIntervalSinceNow: 0)
        
//        datePicker.locale = NSCalendar(calendarIdentifier: .chinese)
        datePicker.calendar = Calendar(identifier: .chinese)
        switch remindType {
        case .edit:
            contentTextField.text = remindModel.content
            remarkTextField.text = remindModel.remark
            repeatLabel.text = XCRemindRepeatType(rawValue: Int(remindModel.repeatType))?.title
            markTypeLabel.text = XCRemindMarkType(rawValue: Int(remindModel.markType))?.title
            saveSwitch.setOn(remindModel.isSaveToCalendar, animated: true)
            datePicker.setDate(Date(timeIntervalSince1970: remindModel.time), animated: true)
            remindID = remindModel.id
        case .add:
            datePicker.setDate(Date(timeIntervalSinceNow: 60 * 60), animated: true)
        }
    }
}

extension XCRemindWriteController {
    
    @IBAction func repeatAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "请选择重复规则", message: nil, preferredStyle: .actionSheet)
        let types: [XCRemindRepeatType] = [.none, .everyDay, .everyWeek, .everyMonth, .everyYear]
        for type in types {
            alertController.addAction(UIAlertAction(title: type.title, style: .default, handler: { (action) in
                self.repeatLabel.text = type.title
                self.repeatType = type
            }))
        }
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
            
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func saveSwitch(_ sender: UISwitch) {
        
    }
    
    private func markTypeAction() {
        let alertController = UIAlertController(title: "请选择事件类型", message: nil, preferredStyle: .actionSheet)
        let types: [XCRemindMarkType] = [.none, .birthday, .anniversary, .holiday, .other]
        for type in types {
            alertController.addAction(UIAlertAction(title: type.title, style: .default, handler: { (action) in
                self.markTypeLabel.text = type.title
                self.markType = type
            }))
        }
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
            
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func finishAction(_ sender: UIBarButtonItem) {
        finish()
        navigationController?.popViewController(animated: true)
    }
    
    private func finish() {
        remindType == .add ? add() : edit()
    }
}


extension XCRemindWriteController {
    
    private func add() {
        let remind: XCRemind = NSEntityDescription.insertNewObject(forEntityName: CoreDataEntityNameType.remind.rawValue, into: remindContext) as! XCRemind
        remind.id = Int64(Date().timeIntervalSince1970)
        remind.content = contentTextField.text
        remind.remark = remarkTextField.text
        remind.time = datePicker.date.timeIntervalSince1970
        remind.repeatType = Int64(repeatType.rawValue)
        remind.isOpen = true
        remind.markType = Int64(markType.rawValue)
        remind.isSaveToCalendar = saveSwitch.isOn
        
        CoreDataTool.save(remindContext)
    }
    
    private func edit() {
        let predicate = NSPredicate(format: "id = %d", remindID)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityNameType.remind.rawValue)
        fetchRequest.predicate = predicate
        
        var remind = [XCRemind]()
        do {
            remind = try remindContext.fetch(fetchRequest) as! [XCRemind]
        } catch  {
            fatalError()
        }
        
        for r in remind {
            r.content = contentTextField.text
            r.remark = remarkTextField.text
            r.time = datePicker.date.timeIntervalSince1970
            r.repeatType = Int64(repeatType.rawValue)
            r.markType = Int64(markType.rawValue)
            r.isSaveToCalendar = saveSwitch.isOn
        }
        CoreDataTool.save(remindContext)
    }

}
