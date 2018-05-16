//
//  CoreDataWorker.swift
//  StructCoreData
//
//  Created by Matt Tian on 2018/4/23.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataWorkerProtocol {
    associatedtype Entity
    func get(with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, fetchLimit: Int?, completion: @escaping (Result<[Entity]>) -> Void)
    func update(entities: [Entity], completion: @escaping (Error?) -> Void)
}

class CoreDataWorker<ManagedObject, Entity>: CoreDataWorkerProtocol where ManagedObject: NSManagedObject & ManagedObjectProtocol, Entity: ManagedObjectConvertible {
    
    let coreData: CoreDataManager
    
    init(coreData: CoreDataManager = CoreDataManager.shared) {
        self.coreData = coreData
    }
    
    func get(with predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int? = nil, completion: @escaping (Result<[Entity]>) -> Void) {
        coreData.performForegroundTask { context in
            do {
                let fetchRequest = ManagedObject.fetchRequest()
                fetchRequest.predicate = predicate
                fetchRequest.sortDescriptors = sortDescriptors
                if let fetchLimit = fetchLimit {
                    fetchRequest.fetchLimit = fetchLimit
                }
                let results = try context.fetch(fetchRequest) as? [ManagedObject]
                let items: [Entity] = results?.compactMap { $0.toEntity() as? Entity } ?? []
                completion(.success(items))
            } catch {
                NSLog("Core Data fetch error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func update(entities: [Entity], completion: @escaping (Error?) -> Void) {
        coreData.performBackgroundTask { context in
            _ = entities.compactMap { (entity) -> ManagedObject? in
                return entity.toManagedObject(context: context) as? ManagedObject
            }
            
            do {
                try context.save()
                completion(nil)
            } catch {
                NSLog("Core Data save error: \(error)")
                completion(error)
            }
        }
    }
    
}
