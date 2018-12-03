//
//  XCRemind+CoreDataProperties.swift
//  
//
//  Created by Sunshine Days on 2018/8/3.
//
//

import Foundation
import CoreData


extension XCRemind {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<XCRemind> {
        return NSFetchRequest<XCRemind>(entityName: kXCRemindEntityName)
    }

    @NSManaged public var id: Int64
    @NSManaged public var content: String?
    @NSManaged public var remark: String?
    @NSManaged public var time: Double
    @NSManaged public var repeatType: Int64
    @NSManaged public var isOpen: Bool
    @NSManaged public var markType: Int64
    @NSManaged public var isSaveToCalendar: Bool

}
