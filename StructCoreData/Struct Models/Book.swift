//
//  Book.swift
//  StructCoreData
//
//  Created by Tong Tian on 22/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

struct Book {
    let uuid: String
    var title: String?
    var price: Double?
    var publisher: String?
    var author: Author?
}

extension Book {
    init(id: String) {
        uuid = id
        title = nil
        price = nil
        publisher = nil
        author = nil
    }
}
