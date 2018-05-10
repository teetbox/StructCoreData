//
//  BooksDataModel.swift
//  StructCoreData
//
//  Created by Matt Tian on 2018/4/23.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

protocol BooksDataModelProtocol {
    var store: Store? { get set }
    func fetchBooks(forStoreId uuid: String, completion: @escaping ([Book]?, _ isLocal: Bool) -> Void)
}

class BooksDataModel: BooksDataModelProtocol {
    
    let dataEngine: CoreDataServiceProtocol
    
    var store: Store?

    init(dataEngine: CoreDataServiceProtocol = CoreDataEngine()) {
        self.dataEngine = dataEngine
    }
    
    func fetchBooks(forStoreId uuid: String, completion: @escaping ([Book]?, Bool) -> Void) {
        let predicate = NSPredicate(format: "store.uuid = %@", uuid)

        dataEngine.fetch(with: predicate) { (result: Result<[Book]>) in
            switch result {
            case .success(let items):
                completion(items + items + items + items + items, true)
            case .failure(let error):
                NSLog("Fetch notes error: \(error)")
                completion(nil, true)
            }
        }
        
        // Networking happens here
        DispatchQueue.global().async {
            sleep(2)
            let newBooks = Array(repeating: Book(uuid: "ss", title: "new", price: nil, publisher: nil, author: nil, notes: nil), count: 3)
            completion(newBooks, false)
        }
    }
    
}
