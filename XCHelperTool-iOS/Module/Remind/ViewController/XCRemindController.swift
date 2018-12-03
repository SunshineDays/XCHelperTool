//
//  XCRemindController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/1.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit
import CoreData

/// 提醒
class XCRemindController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var remindContext: NSManagedObjectContext!
    
    private var remindModels = [XCRemind]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        getCoreData()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension XCRemindController {

    private func getCoreData() {
        remindContext = CoreDataTool.managedObjectContext(.remind)
        if let results = CoreDataTool.list(remindContext, entityName: .remind) {
            remindModels.removeAll()
            for r in results {
                let model: XCRemind = r as! XCRemind
                remindModels.append(model)
            }
            remindModels.sort { (m1, m2) -> Bool in
                m1.time < m2.time
            }
        }
    }
    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(R.nib.xcRemindCell)
        tableView.tableFooterView = UIView()
    }
}

extension XCRemindController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return remindModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.xcRemindCell, for: indexPath)!
        let model = remindModels[indexPath.row]
        cell.delegate = self
        cell.configCell(model: model, indexPath: indexPath)
        return cell
    }
    
    private func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let predicate = NSPredicate(format: "id = %d", remindModels[indexPath.row].id)
        CoreDataTool.delete(remindContext, predicate: predicate, entityName: .remind)
        
        remindModels.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        getCoreData()
        let vc = R.storyboard.xcRemind.xcRemindWriteController()!
        vc.initWith(model: remindModels[indexPath.row], remindType: .edit)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension XCRemindController: XCRemindCellDelegate {
    /// 修改打开状态
    func remindCell(_ cell: XCRemindCell, clickButton sender: UIButton, indexPath: IndexPath) {
        let predicate = NSPredicate(format: "id = %d", remindModels[indexPath.row].id)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityNameType.remind.rawValue)
        fetchRequest.predicate = predicate
        
        var remind = [XCRemind]()
        do {
            remind = try remindContext.fetch(fetchRequest) as! [XCRemind]
        } catch  {
            fatalError()
        }
        
        for r in remind {
            r.isOpen = sender.isSelected
        }
        
        CoreDataTool.save(remindContext)
    }
}

extension XCRemindController {
    @IBAction func addAction(_ sender: UIButton) {
        let vc = R.storyboard.xcRemind.xcRemindWriteController()!
        vc.initWith(model: nil, remindType: .add)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
