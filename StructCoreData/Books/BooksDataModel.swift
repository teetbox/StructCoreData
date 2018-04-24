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
    func fetchBooks(forStoreId uuid: String, completion: @escaping ([Book]?) -> Void)
}

class BooksDataModel: BooksDataModelProtocol {
    var books: [Book]?
    
    let worker: CoreDataWorker<BookMO, Book>
    
    init(worker: CoreDataWorker<BookMO, Book> = CoreDataWorker<BookMO, Book>()) {
        self.worker = worker
    }
    
    func fetchBooks(forStoreId uuid: String, completion: @escaping ([Book]?) -> Void) {
        let predicate = NSPredicate(format: "store.uuid = %@", uuid)
        worker.get(with: predicate) { (result: Result<[Book]>) in
            switch result {
            case .success(let items):
                self.books = items
                completion(items)
            case .failure(let error):
                NSLog("Fetch notes error: \(error)")
                completion(nil)
            }
        }
    }
}
