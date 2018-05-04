//
//  BooksDataModel.swift
//  StructCoreData
//
//  Created by Matt Tian on 2018/4/23.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

protocol BooksDataModelProtocol {
    func fetchBooks(forStoreId uuid: String, completion: @escaping ([Book]?) -> Void)
}

class BooksDataModel: BooksDataModelProtocol {
    
    let dataEngine: CoreDataServiceProtocol
    
    init(dataEngine: CoreDataServiceProtocol = CoreDataEngine()) {
        self.dataEngine = dataEngine
    }
    
    func fetchBooks(forStoreId uuid: String, completion: @escaping ([Book]?) -> Void) {
        let predicate = NSPredicate(format: "store.uuid = %@", uuid)

        dataEngine.get(with: predicate) { (result: Result<[Book]>) in
            switch result {
            case .success(let items):
                completion(items)
            case .failure(let error):
                NSLog("Fetch notes error: \(error)")
                completion(nil)
            }
        }
    }
}
