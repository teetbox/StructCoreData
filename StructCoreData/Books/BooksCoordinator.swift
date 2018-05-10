//
//  BooksCoordinator.swift
//  StructCoreData
//
//  Created by Matt Tian on 2018/5/10.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import UIKit

class BooksCoordinator {
    
    let window: UIWindow
    
    var store: Store?
    
    var booksViewController: BooksViewController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let dataModel = BooksDataModel()
        dataModel.store = store
        
        let viewModel = BooksViewModel(dataModel: dataModel)
        viewModel.coordinator = self
        
        booksViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BooksViewController") as? BooksViewController
        booksViewController!.viewModel = viewModel
        booksViewController!.navigationItem.title = "Amazon"
        
        let topNavigation = UIApplication.topNaviController()
        topNavigation?.pushViewController(booksViewController!, animated: true)
    }
    
}

extension BooksCoordinator: BooksViewModelCoordinatorDelegate {
    
    func showNewsAlert() {
        booksViewController?.reloadBooks()
    }
    
}
