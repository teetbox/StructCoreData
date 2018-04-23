//
//  CoreDataManager.swift
//  StructCoreData
//
//  Created by Matt Tian on 2018/4/23.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StructCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        let context:NSManagedObjectContext = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.viewContext.perform {
            block(self.viewContext)
        }
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.persistentContainer.performBackgroundTask(block)
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func resetData() {
        let entities = persistentContainer.managedObjectModel.entities
        entities.flatMap ({ $0.name }).forEach(clearEntity)
        
        createDummyData()
    }
    
    private func clearEntity(_ name: String) {
        let deleteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        let batchDelete = NSBatchDeleteRequest(fetchRequest: deleteRequest)
        
        do {
            try viewContext.execute(batchDelete)
        } catch {
            NSLog("Batch delete error for \(name): \(error)")
        }
    }
    
    private func createDummyData() {
        let amazonStore = StoreMO(context: viewContext)
        amazonStore.uuid = UUID().uuidString
        amazonStore.brand = "Amazon"
        amazonStore.address = "410 Terry Ave North, Seattle"
        amazonStore.telephone = "1-206-266-2992"
        
        let safariStore = StoreMO(context: viewContext)
        safariStore.uuid = UUID().uuidString
        safariStore.brand = "Safari"
        safariStore.address = "1003 Gravenstein Highway North Sebastopol, CA"
        safariStore.telephone = "1-800-775-7330"
        
        let charles = AuthorMO(context: viewContext)
        charles.uuid = UUID().uuidString
        charles.name = "Charles Duhigg"
        charles.birthday = Date(timeIntervalSince1970: 0)
        charles.gender = true
        charles.email = "charles@gmail.com"
        
        let smarterFasterBetter = BookMO(context: viewContext)
        smarterFasterBetter.uuid = UUID().uuidString
        smarterFasterBetter.title = "Smarter Faster Better"
        smarterFasterBetter.price = 56.1
        smarterFasterBetter.publisher = "Random House"
        smarterFasterBetter.author = charles
        
        let thePowerOfHabit = BookMO(context: viewContext)
        thePowerOfHabit.uuid = UUID().uuidString
        thePowerOfHabit.title = "The power of habit"
        thePowerOfHabit.price = 69.7
        thePowerOfHabit.publisher = "Random House"
        thePowerOfHabit.author = charles
        
        amazonStore.addToBooks(smarterFasterBetter)
        amazonStore.addToBooks(thePowerOfHabit)
        
        let chris = AuthorMO(context: viewContext)
        chris.uuid = UUID().uuidString
        chris.name = "Chris Eidhof"
        chris.birthday = Date(timeIntervalSince1970: 0)
        chris.gender = true
        chris.email = "chris@objc.com"
        
        let advancedSwift = BookMO(context: viewContext)
        advancedSwift.uuid = UUID().uuidString
        advancedSwift.title = "Advanced Swift"
        advancedSwift.price = 310.9
        advancedSwift.publisher = "Createspace Independent Pub"
        advancedSwift.author = chris
        
        let functionalSwift = BookMO(context: viewContext)
        functionalSwift.uuid = UUID().uuidString
        functionalSwift.title = "Functional Swift"
        functionalSwift.price = 486
        functionalSwift.publisher = "Florian Kugler"
        functionalSwift.author = chris
        
        let florian = AuthorMO(context: viewContext)
        florian.uuid = UUID().uuidString
        florian.name = "Florian Kugler"
        florian.birthday = Date(timeIntervalSince1970: 0)
        florian.gender = false
        florian.email = "florian@objc.com"
        
        let coreData = BookMO(context: viewContext)
        coreData.uuid = UUID().uuidString
        coreData.title = "Core Data"
        coreData.price = 310.9
        coreData.publisher = "Createspace Independent Pub"
        coreData.author = florian
        
        safariStore.addToBooks(advancedSwift)
        safariStore.addToBooks(functionalSwift)
        safariStore.addToBooks(coreData)
        
        let userA = UserMO(context: viewContext)
        userA.uuid = UUID().uuidString
        userA.username = "User A"
        userA.email = "a@user.com"
        
        let noteA = NoteMO(context: viewContext)
        noteA.uuid = UUID().uuidString
        noteA.content = "Core Data is cool"
        noteA.createDate = Date()
        noteA.user = userA
        
        let userB = UserMO(context: viewContext)
        userB.uuid = UUID().uuidString
        userB.username = "User B"
        userB.email = "b@user.com"
        
        let noteB = NoteMO(context: viewContext)
        noteB.uuid = UUID().uuidString
        noteB.content = "Core Data could do the data persistency work, but it's power is more than that."
        noteB.createDate = Date()
        noteB.user = userB
        
        coreData.addToNotes(noteA)
        coreData.addToNotes(noteB)
        
        saveContext()
    }
    
}
