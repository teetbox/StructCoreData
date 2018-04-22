//
//  BookMO+CoreDataProperties.swift
//  StructCoreData
//
//  Created by Tong Tian on 22/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

extension BookMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookMO> {
        return NSFetchRequest<BookMO>(entityName: "BookMO")
    }

    @NSManaged public var uuid: String?
    @NSManaged public var title: String?
    @NSManaged public var publisher: String?
    @NSManaged public var price: Double
    @NSManaged public var author: AuthorMO?
    @NSManaged public var store: StoreMO?

}
