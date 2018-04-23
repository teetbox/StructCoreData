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
    func fetchNotes(completion: @escaping ([Note]?) -> Void)
}

class NotesDataModel: NotesDataModelProtocol {
    
    let worker: CoreDataWorker<NoteMO, Note>
    
    var book: Book?
    var notes: [Note]?
    
    init(worker: CoreDataWorker<NoteMO, Note> = CoreDataWorker<NoteMO, Note>()) {
        self.worker = worker
    }
    
    func fetchNotes(completion: @escaping ([Note]?) -> Void) {
        worker.get { (result: Result<[Note]>) in
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
    
}
