//
//  NotesDataModel.swift
//  StructCoreData
//
//  Created by Tong Tian on 23/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

protocol NotesDataModelProtocol {
    var book: Book? { get set }
    var notes: [Note]? { get set }
    func fetchBook(uuid: String, completion: @escaping (Book?) -> Void)
    func fetchNotes(forBookId uuid: String, completion: @escaping ([Note]?) -> Void)
    func insertNote(_ note: Note)
}

class NotesDataModel: NotesDataModelProtocol {
    
    let worker: CoreDataWorker<NoteMO, Note>
    let service: CoreDataServiceProtocol
    
    var book: Book?
    var notes: [Note]?
    
    init(worker: CoreDataWorker<NoteMO, Note> = CoreDataWorker<NoteMO, Note>()) {
        self.worker = worker
        self.service = CoreDataService()
    }
    
    func fetchBook(uuid: String, completion: @escaping (Book?) -> Void) {
        let predicate = NSPredicate(format: "uuid = %@", uuid)
        
        service.get(with: predicate) { (result: Result<[Book]>) in
            switch result {
            case .success(let items):
                self.book = items.first
                completion(items.first)
            case .failure(let error):
                NSLog("Fetch book error: \(error)")
                completion(nil)
            }
        }
    }
    
    func fetchNotes(forBookId uuid: String, completion: @escaping ([Note]?) -> Void) {
        let predicate = NSPredicate(format: "book.uuid = %@", uuid)
        worker.get(with: predicate) { (result: Result<[Note]>) in
            switch result {
            case .success(let items):
                self.notes = items
                completion(items)
            case .failure(let error):
                NSLog("Fetch notes error: \(error)")
                completion(nil)
            }
        }
    }
    
    func insertNote(_ note: Note) {
        worker.update(entities: [note]) { error in
            if let error = error {
                NSLog("Insert note error: \(error)")
            }
        }
    }
    
}
