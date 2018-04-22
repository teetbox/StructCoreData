//
//  UserMO+CoreDataProperties.swift
//  StructCoreData
//
//  Created by Tong Tian on 22/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

extension UserMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserMO> {
        return NSFetchRequest<UserMO>(entityName: "UserMO")
    }

    @NSManaged public var uuid: String
    @NSManaged public var username: String?
    @NSManaged public var email: String?
    @NSManaged public var notes: NoteMO?

}
