//
//  StoresDataModel.swift
//  StructCoreData
//
//  Created by Matt Tian on 2018/4/23.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

protocol StoresDataModelProtocol {
    func fetchStores(completion: @escaping ([Store]?) -> Void)
}

class StoresDataModel: StoresDataModelProtocol {
    
    let worker: CoreDataWorker<StoreMO, Store>
    
    var stores: [Store]?
    
    init(worker: CoreDataWorker<StoreMO, Store> = CoreDataWorker<StoreMO, Store>()) {
        self.worker = worker
    }
    
    func fetchStores(completion: @escaping ([Store]?) -> Void) {
        let sort = NSSortDescriptor(key: "brand", ascending: true)
        worker.get(sortDescriptors: [sort]) { (result: Result<[Store]>) in
            switch result {
            case .success(let items):
                self.stores = items
                completion(items)
            case .failure(let error):
                NSLog("Fetch Books error: \(error)")
                completion(nil)
            }
        }
    }
    
}
