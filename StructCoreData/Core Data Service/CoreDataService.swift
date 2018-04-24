//
//  CoreDataService.swift
//  StructCoreData
//
//  Created by Tong Tian on 24/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol {
    
    func get<Entity: ManagedObjectConvertible>(with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, fetchLimit: Int?, completion: @escaping (Result<[Entity]>) -> Void)
    
    func put<Entity: ManagedObjectConvertible>(entities: [Entity], completion: @escaping (Error?) -> Void)
    
}

class CoreDataService: CoreDataServiceProtocol {
    
    let coreData: CoreDataManager
    
    init(coreData: CoreDataManager = CoreDataManager.shared) {
        self.coreData = coreData
    }
    
    func get<Entity>(with predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int? = nil, completion: @escaping (Result<[Entity]>) -> Void) where Entity : ManagedObjectConvertible {
        
        coreData.performForegroundTask { context in
            do {
                let fetchRequest = Entity.ManagedObject.fetchRequest()
                fetchRequest.predicate = predicate
                fetchRequest.sortDescriptors = sortDescriptors
                if let fetchLimit = fetchLimit {
                    fetchRequest.fetchLimit = fetchLimit
                }
                
                let results = try context.fetch(fetchRequest) as? [Entity.ManagedObject]
                let items = results?.flatMap { $0.toEntity() as? Entity } ?? []
                completion(.success(items))
            } catch {
                NSLog("Core Data fetch error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func put<Entity>(entities: [Entity], completion: @escaping (Error?) -> Void) where Entity : ManagedObjectConvertible {
        
        coreData.performBackgroundTask { context in
            _ = entities.flatMap { $0.toManagedObject(context: context) }
            
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
