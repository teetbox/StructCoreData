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
    func deleteNote(note: Note, completion: @escaping (Error?) -> Void)
}

class NotesDataModel: NotesDataModelProtocol {

    let dataEngine: CoreDataServiceProtocol
    
    var book: Book?
    var notes: [Note]?
    
    init(dataEngine: CoreDataServiceProtocol = CoreDataEngine()) {
        self.dataEngine = dataEngine
    }
    
    func fetchBook(uuid: String, completion: @escaping (Book?) -> Void) {
        let predicate = NSPredicate(format: "uuid = %@", uuid)
        
        dataEngine.get(with: predicate) { (result: Result<[Book]>) in
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
    
    func deleteNote(note: Note, completion: @escaping (Error?) -> Void) {
        dataEngine.delete(entities: [note]) { error in
            if let error = error {
                NSLog("Delete note error: \(error)")
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
}
