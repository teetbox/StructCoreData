//
//  AuthorMO+CoreDataClass.swift
//  StructCoreData
//
//  Created by Tong Tian on 22/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

@objc(AuthorMO)
public class AuthorMO: NSManagedObject {}

extension AuthorMO: ManagedObjectProtocol {
    func toEntity() -> Author? {
        return Author(uuid: uuid, name: name, email: email, birthday: birthday, gender: gender)
    }
}

extension Author: ManagedObjectConvertible {
    func toManagedObject(context: NSManagedObjectContext) -> AuthorMO? {
        let author = AuthorMO.getOrCreate(withId: uuid, in: context)
        author.name = name
        author.email = email
        author.birthday = birthday
        author.gender = gender ?? false
        return author
    }
}
