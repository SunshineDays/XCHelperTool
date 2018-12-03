//
//  CoreDataTool.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/3.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTool: NSObject {

    /// 创建托管对象
    class func managedObjectContext(_ entityName: CoreDataEntityNameType) -> NSManagedObjectContext {
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//        let context = appDelegate.persistentContainer.viewContext
        
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        let modelPath = Bundle.main.url(forResource: entityName.rawValue, withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOf: modelPath)!
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        var dataPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        dataPath = dataPath + "/\(entityName).sqlite"
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: URL(fileURLWithPath: dataPath), options: nil)
        } catch  {
            fatalError("获取惜败")
        }
        
        context.persistentStoreCoordinator = coordinator
        
        return context
    }
    
    /// 获取CoreData数据
    class func list(_ context: NSManagedObjectContext, entityName: CoreDataEntityNameType) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName.rawValue)
        do {
            let fetchedResults = try context.fetch(fetchRequest) as? [NSManagedObject]
            return fetchedResults
        } catch  {
            fatalError("获取失败")
        }
    }
    
    /// 删除某条数据
    class func delete(_ context: NSManagedObjectContext, predicate: NSPredicate, entityName: CoreDataEntityNameType) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName.rawValue)
        fetchRequest.predicate = predicate
        
        var managedObject = [NSManagedObject]()
        do {
            managedObject = try context.fetch(fetchRequest) as! [NSManagedObject]
        } catch  {
            fatalError()
        }
        for m in managedObject {
            context.delete(m)
        }
        save(context)
    }

    /// 保存操作
    class func save(_ context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("操作惜败")
            }
        }
    }
    
}
