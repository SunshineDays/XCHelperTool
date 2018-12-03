//
//  XCChatUpWriteController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/23.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit
import CoreData

/// 弹幕弹窗输入
class XCChatUpWriteController: BaseTableViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    private var historyContext: NSManagedObjectContext!
    
    private var historyModels = [XCChatUpWriteHistory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        getCoreData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getCoreData() {
        historyContext = CoreDataTool.managedObjectContext(.chatupHistory)
        if let results = CoreDataTool.list(historyContext, entityName: .chatupHistory) {
            for r in results {
                let model: XCChatUpWriteHistory = r as! XCChatUpWriteHistory
                historyModels.append(model)
            }
            historyModels.sort { (m1, m2) -> Bool in
                m1.createTime > m2.createTime
            }
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = historyModels[indexPath.row].title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if historyModels.count > 0 {
            let view = UIView()
            view.backgroundColor = UIColor.clear
            let label = UILabel(frame: CGRect(x: 15, y: 15, width: 200, height: 25))
            label.text = "历史记录"
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 14)
            view.addSubview(label)
            return view
        } else {
            return ClearView()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let predicate = NSPredicate(format: "title = %@", historyModels[indexPath.row].title ?? "")
        CoreDataTool.delete(historyContext, predicate: predicate, entityName: .chatupHistory)
        
        historyModels.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = historyModels[indexPath.row].title ?? ""
        edit(title: title)
        navigationController?.popViewController(animated: true)
    }

}

extension XCChatUpWriteController {
    @IBAction func finishAction(_ sender: UIBarButtonItem) {
        if (textField.text ?? "").count > 0 {
            if historyModels.contains(where: { $0.title == textField.text! }) { //修改
                edit(title: textField.text!)
            } else { //添加
                add()
            }
            navigationController?.popViewController(animated: true)
        } else {
            MBProgressHUD.show(info: "请输入内容")
        }
    }
    
    private func edit(title: String) { //修改
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityNameType.chatupHistory.rawValue)
        fetchRequest.predicate = NSPredicate(format: "title = %@", title)
        var models = [XCChatUpWriteHistory]()
        do {
            models = try historyContext.fetch(fetchRequest) as! [XCChatUpWriteHistory]
        } catch {
            fatalError()
        }
        for m in models {
            m.createTime = Date().timeIntervalSince1970
        }
        CoreDataTool.save(historyContext)
    }
    
    private func add() { //添加
        let model: XCChatUpWriteHistory = NSEntityDescription.insertNewObject(forEntityName: CoreDataEntityNameType.chatupHistory.rawValue, into: historyContext) as! XCChatUpWriteHistory
        model.title = textField.text
        model.createTime = Date().timeIntervalSince1970
        CoreDataTool.save(historyContext)
    }
    
}
