//
//  BooksDataModel.swift
//  StructCoreData
//
//  Created by Matt Tian on 2018/4/23.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

protocol BooksDataModelProtocol {
    var books: [Book]? { get set }
}

class BooksDataModel: BooksDataModelProtocol {
    var books: [Book]?
    
}
