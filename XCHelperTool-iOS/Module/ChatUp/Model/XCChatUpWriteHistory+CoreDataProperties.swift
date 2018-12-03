//
//  XCChatUpWriteHistory+CoreDataProperties.swift
//  
//
//  Created by Sunshine Days on 2018/8/6.
//
//

import Foundation
import CoreData


extension XCChatUpWriteHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<XCChatUpWriteHistory> {
        return NSFetchRequest<XCChatUpWriteHistory>(entityName: "XCChatUpWriteHistory")
    }

    @NSManaged public var title: String?
    @NSManaged public var createTime: Double

}
