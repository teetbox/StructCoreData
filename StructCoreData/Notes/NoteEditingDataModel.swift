//
//  NoteEditingDataModel.swift
//  StructCoreData
//
//  Created by Tong Tian on 24/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

protocol NoteEditingDataModelProtocol {
    func save(_ note: Note, for book: Book, completion: @escaping (Error?) -> Void)
}

class NoteEditingDataModel: NoteEditingDataModelProtocol {

    let worker: CoreDataServiceProtocol
    
    init(worker: CoreDataServiceProtocol = CoreDataEngine()) {
        self.worker = worker
    }
    
    func save(_ note: Note, for book: Book, completion: @escaping (Error?) -> Void) {
        var notes = book.notes
        notes?.append(note)

        var book = book
        book.notes = notes

        worker.update(entities: [book]) { error in
            completion(error)
        }
    }
    
}
