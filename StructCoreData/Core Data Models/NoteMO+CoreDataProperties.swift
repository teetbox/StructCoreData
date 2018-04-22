//
//  NoteMO+CoreDataProperties.swift
//  StructCoreData
//
//  Created by Tong Tian on 22/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

extension NoteMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteMO> {
        return NSFetchRequest<NoteMO>(entityName: "NoteMO")
    }

    @NSManaged public var uuid: String
    @NSManaged public var content: String?
    @NSManaged public var createDate: Date?
    @NSManaged public var updateDate: Date?
    @NSManaged public var user: UserMO?

}
