//
//  StoreMO+CoreDataClass.swift
//  StructCoreData
//
//  Created by Tong Tian on 22/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

@objc(StoreMO)
public class StoreMO: NSManagedObject {}

extension StoreMO: ManagedObjectProtocol {
    func toEntity() -> Store? {
        var store = Store(id: uuid)
        store.brand = brand
        store.address = address
        store.telephone = telephone
        store.books = (books?.allObjects as? [BookMO])?.compactMap { $0.toEntity() }
        return store
    }
}

extension Store: ManagedObjectConvertible {
    func toManagedObject(context: NSManagedObjectContext) -> StoreMO? {
        let store = StoreMO.getOrCreate(withId: uuid, in: context)
        store.brand = brand
        store.address = address
        store.telephone = telephone
        if let books = books?.compactMap({ $0.toManagedObject(context: context) }) {
            store.books = NSSet(array: books)
        }
        return store
    }
}
