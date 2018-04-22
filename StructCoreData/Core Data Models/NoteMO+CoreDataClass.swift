//
//  NoteMO+CoreDataClass.swift
//  StructCoreData
//
//  Created by Tong Tian on 22/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

@objc(NoteMO)
public class NoteMO: NSManagedObject {}

extension NoteMO: ManagedObjectProtocol {
    func toEntity() -> Note? {
        var note = Note(id: uuid)
        note.content = content
        note.createDate = createDate
        note.updateDate = updateDate
        note.user = user?.toEntity()
        return note
    }
}
