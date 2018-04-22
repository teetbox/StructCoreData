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
    let brand: String
    let address: String
    let telephone: String
    var books: [Book]
}
