//
//  StoreMO+CoreDataProperties.swift
//  StructCoreData
//
//  Created by Tong Tian on 22/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

extension StoreMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoreMO> {
        return NSFetchRequest<StoreMO>(entityName: "StoreMO")
    }

    @NSManaged public var uuid: String
    @NSManaged public var address: String?
    @NSManaged public var brand: String?
    @NSManaged public var telephone: String?
    @NSManaged public var books: NSSet?

}

// MARK: Generated accessors for books
extension StoreMO {

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: BookMO)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: BookMO)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSSet)

}
