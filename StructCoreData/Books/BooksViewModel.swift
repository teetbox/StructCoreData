//
//  BooksViewModel.swift
//  StructCoreData
//
//  Created by Matt Tian on 2018/5/10.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

protocol BooksViewModelCoordinatorDelegate {
    func showNewsAlert()
}

class BooksViewModel {
    
    var coordinator: BooksViewModelCoordinatorDelegate?
    
    let dataModel: BooksDataModelProtocol
    var store: Store?
    
    var books: [Book]?
    
    init(dataModel: BooksDataModelProtocol) {
        self.dataModel = dataModel
        self.store = dataModel.store
    }
    
    func loadData(completion: @escaping () -> Void) {
        guard let storeId = store?.uuid else { return }

        dataModel.fetchBooks(forStoreId: storeId) { (books, isLocal) in
            
            DispatchQueue.main.async {
                if isLocal {
                    self.books = books
                    completion()
                } else {
                    self.books! = books! + self.books!
                    self.coordinator?.showNewsAlert()
                }
            }
        }
    }
    
}
