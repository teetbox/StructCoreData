//
//  Store.swift
//  StructCoreData
//
//  Created by Tong Tian on 22/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

struct Store {
    let uuid: String
    var brand: String?
    var address: String?
    var telephone: String?
    var books: [Book]?
}

extension Store {
    init(id: String) {
        uuid = id
        brand = nil
        address = nil
        telephone = nil
        books = nil
    }
}
