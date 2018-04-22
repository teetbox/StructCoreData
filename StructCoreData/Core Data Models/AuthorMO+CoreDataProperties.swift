//
//  AuthorMO+CoreDataProperties.swift
//  StructCoreData
//
//  Created by Tong Tian on 22/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

extension AuthorMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AuthorMO> {
        return NSFetchRequest<AuthorMO>(entityName: "AuthorMO")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var birthday: Date?
    @NSManaged public var gender: Bool
    @NSManaged public var uuid: String
    @NSManaged public var book: BookMO?

}
