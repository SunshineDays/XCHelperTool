//
//  XCChatUp+CoreDataProperties.swift
//  
//
//  Created by Sunshine Days on 2018/8/6.
//
//

import Foundation
import CoreData

extension XCChatUp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<XCChatUp> {
        return NSFetchRequest<XCChatUp>(entityName: "XCChatUp")
    }

    @NSManaged public var speed: Int16
    @NSManaged public var font: Int16
    @NSManaged public var style: Int16
    @NSManaged public var color: Int16

}
