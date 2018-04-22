//
//  Note.swift
//  StructCoreData
//
//  Created by Tong Tian on 22/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

struct Note {
    let uuid: String
    var content: String?
    var createDate: Date?
    var updateDate: Date?
    var user: User?
}

extension Note {
    init(id: String) {
        uuid = id
        content = nil
        createDate = nil
        updateDate = nil
        user = nil
    }
}
