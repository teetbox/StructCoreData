//
//  User.swift
//  StructCoreData
//
//  Created by Tong Tian on 22/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

struct User {
    let uuid: String
    var username: String?
    var email: String?
}

extension User {
    init(id: String) {
        uuid = id
        username = nil
        email = nil
    }
}
