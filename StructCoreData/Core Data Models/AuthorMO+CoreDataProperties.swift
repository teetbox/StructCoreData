//
//  AuthorMO+CoreDataProperties.swift
//  StructCoreData
//
//  Created by Matt Tian on 2018/4/24.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

extension AuthorMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AuthorMO> {
        return NSFetchRequest<AuthorMO>(entityName: "AuthorMO")
    }

    @NSManaged public var uuid: String
    @NSManaged public var name: String?
    @NSManaged public var birthday: Date?
    @NSManaged public var email: String?
    @NSManaged public var gender: Bool
    @NSManaged public var books: NSSet?

}

// MARK: Generated accessors for books
extension AuthorMO {

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: BookMO)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: BookMO)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSSet)

}
